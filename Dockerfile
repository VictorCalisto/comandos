# Imagem LTS mais recente
# Com OpenSSL 1.1 e 3
# =============================================================================
# Stage 1: Dependencies base — Prepara ambiente com todas as dependências
# =============================================================================
FROM ubuntu:24.04 as dependencies_base

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    TZ=America/Sao_Paulo

# Configurar timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Instalar dependências base (separar por categoria para cache melhor)
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Build essentials
    build-essential \
    autoconf \
    automake \
    bison \
    libtool \
    patch \
    pkg-config \
    # SSL/Crypto
    libssl-dev \
    # Desenvolvimento
    git \
    curl \
    wget \
    gnupg2 \
    # Compilação Ruby
    libffi-dev \
    libgdbm-dev \
    libreadline-dev \
    libsqlite3-dev \
    libyaml-dev \
    zlib1g-dev \
    libncurses-dev \
    # Banco de dados
    libpq-dev \
    sqlite3 \
    postgresql-client \
    # Processamento
    libreoffice \
    wkhtmltopdf \
    pdftk \
    # Ferramentas de sistema
    make \
    python3-dev \
    perl \
    && rm -rf /var/lib/apt/lists/*

# Instalar OpenSSL 1.1.1 customizado (essencial para Ruby < 3.0)
RUN cd /usr/local/src && \
    wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1w.tar.gz && \
    tar -xf openssl-1.1.1w.tar.gz && \
    cd openssl-1.1.1w && \
    ./config --prefix=/opt/openssl-1.1.1 shared zlib && \
    make && make install && \
    rm -rf /usr/local/src/openssl-1.1.1*

# Instalar RVM
RUN gpg2 --keyserver hkp://keyserver.ubuntu.com:80 \
         --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
                    7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc

# Instalar NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> /etc/bash.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /etc/bash.bashrc

WORKDIR /rails

# =============================================================================
# Stage 2: Builder — Compila Ruby, Node e instala dependências
# =============================================================================
FROM dependencies_base as builder

ARG RUBY_VERSION=3.2.0
ARG NODE_VERSION=18.16.0
ARG RAILS_ENV=production
ARG USE_CUSTOM_OPENSSL=false

ENV BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/vendor/bundle \
    NODE_ENV=$RAILS_ENV \
    NVM_DIR=/root/.nvm

# Carregar RVM e NVM no contexto de build
SHELL ["/bin/bash", "-c"]

# Instalar Ruby via RVM
RUN source /etc/profile.d/rvm.sh && \
    if [ "$USE_CUSTOM_OPENSSL" = "true" ]; then \
      echo "Compilando Ruby $RUBY_VERSION com OpenSSL 1.1..." && \
      rvm install $RUBY_VERSION --with-openssl-dir=/opt/openssl-1.1.1 --disable-binary; \
    else \
      echo "Compilando Ruby $RUBY_VERSION com OpenSSL do sistema..." && \
      rvm install $RUBY_VERSION --disable-binary; \
    fi && \
    rvm use $RUBY_VERSION --default && \
    gem update --system 3.4.22 && \
    gem install bundler -v 2.4.22 --no-document

# Instalar Node via NVM
RUN source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install -g npm@latest yarn@latest

# Copiar Gemfile/Gemlock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN source /etc/profile.d/rvm.sh && \
    bundle install --jobs=$(nproc)

# Copiar package.json/package-lock.json
COPY package.json package-lock.json yarn.lock* ./

# Instalar Node dependencies
RUN source $NVM_DIR/nvm.sh && \
    npm ci --omit=dev

# Copiar código da aplicação
COPY . .

# Compilar assets (Rails)
RUN source /etc/profile.d/rvm.sh && \
    source $NVM_DIR/nvm.sh && \
    bundle exec rails assets:precompile 2>/dev/null || echo "Assets já compilados ou não disponíveis"

# Limpar caches
RUN rm -rf node_modules tmp/cache /root/.npm /root/.rvm/archives/*

# =============================================================================
# Stage 3: Runtime — Imagem final otimizada
# =============================================================================
FROM dependencies_base as runtime

ARG RUBY_VERSION=3.2.0
ARG NODE_VERSION=18.16.0
ARG INCLUDE_DEV_TOOLS=false
ARG USE_CUSTOM_OPENSSL=false

ENV BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/vendor/bundle \
    RAILS_ENV=production \
    NVM_DIR=/root/.nvm

SHELL ["/bin/bash", "-c"]

# Instalar Ruby via RVM
RUN source /etc/profile.d/rvm.sh && \
    if [ "$USE_CUSTOM_OPENSSL" = "true" ]; then \
      rvm install $RUBY_VERSION --with-openssl-dir=/opt/openssl-1.1.1 --disable-binary; \
    else \
      rvm install $RUBY_VERSION --disable-binary; \
    fi && \
    rvm use $RUBY_VERSION --default && \
    gem update --system 3.4.22 && \
    gem install bundler -v 2.4.22 --no-document

# Instalar Node via NVM
RUN source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION

# Instalar ferramentas opcionais de desenvolvimento
RUN if [ "$INCLUDE_DEV_TOOLS" = "true" ]; then \
    apt-get update && apt-get install -y --no-install-recommends \
      nano \
      htop \
      iputils-ping \
      vim \
      less \
      && rm -rf /var/lib/apt/lists/*; \
    fi

WORKDIR /rails

# Copiar gems compilados
COPY --from=builder /vendor/bundle /vendor/bundle

# Copiar assets compilados
COPY --from=builder /rails/public/assets ./public/assets 2>/dev/null || true
COPY --from=builder /rails/public/packs ./public/packs 2>/dev/null || true

# Copiar código da aplicação
COPY --chown=1000:1000 . .

# Criar usuário não-root
RUN groupadd -r rails && useradd -r -g rails -u 1000 rails && \
    chown -R rails:rails /rails

USER rails

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD source /etc/profile.d/rvm.sh && \
        source $NVM_DIR/nvm.sh && \
        bundle exec rails status 2>/dev/null || exit 1

# Default command com RVM e NVM carregados
CMD ["/bin/bash", "-c", "source /etc/profile.d/rvm.sh && source $NVM_DIR/nvm.sh && \
    rm -f /rails/tmp/pids/server.pid && \
    bundle exec sidekiq -e $RAILS_ENV & \
    bundle exec rails server -b 0.0.0.0 -p 3000"]

# =============================================================================
# Stage 4: Development — Imagem com todas as ferramentas
# =============================================================================
FROM runtime as development

ARG RUBY_VERSION=3.2.0
ARG NODE_VERSION=18.16.0
ARG USE_CUSTOM_OPENSSL=false

USER root

ENV BUNDLE_DEPLOYMENT=false \
    NVM_DIR=/root/.nvm

SHELL ["/bin/bash", "-c"]

# Instalar ferramentas de desenvolvimento
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    vim \
    htop \
    iputils-ping \
    less \
    man-db \
    && rm -rf /var/lib/apt/lists/*

# Reinstalar gems sem BUNDLE_DEPLOYMENT para desenvolvimento
COPY Gemfile Gemfile.lock ./
RUN source /etc/profile.d/rvm.sh && \
    bundle install --jobs=$(nproc)

USER rails

CMD ["/bin/bash", "-c", "source /etc/profile.d/rvm.sh && source $NVM_DIR/nvm.sh && \
    bundle exec rails server -b 0.0.0.0 -p 3000"]
