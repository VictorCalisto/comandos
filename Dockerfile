# Imagem LTS mais recente
# Com OpenSSL 1.1 e 3
FROM ubuntu:24.04

WORKDIR /

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

# Instala dependências gerais
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        libssl-dev \
        build-essential \
        linux-headers-generic \
        gnupg2 \
        curl \
        tzdata \
        perl \
        bzip2 \
        gawk \
        g++ \
        gcc \
        autoconf \
        automake \
        bison \
        libc6-dev \
        libffi-dev \
        libgdbm-dev \
        libsqlite3-dev \
        libtool \
        libyaml-dev \
        libgmp-dev \
        libreadline-dev \
        libpq-dev \
        libfontconfig1 \
        libxrender1 \
        make \
        python3 \
        patch \
        pkg-config \
        sqlite3 \
        wget \
        zlib1g-dev \
        cron \
        nano \
        htop \
        git \
        iputils-ping \
        postgresql \
        postgresql-client \
        python3-pip \
        python3-venv \
        python3-dev \
        libxml2-dev \
        libxslt1-dev \
        libreoffice \
        libncurses-dev \
        libreadline-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define Python 3 como padrão
RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

# Instala certificados
RUN mkdir -p /usr/local/share/ca-certificates && \
    wget https://secure.globalsign.com/cacert/root-r3.crt -O /usr/local/share/ca-certificates/globalsign_root_r3.crt && \
    update-ca-certificates

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt


# Configura o fuso horário para São Paulo
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Compila OpenSSL 1.1.1 em paralelo sem remover o do sistema
RUN apt-get update && \
    cd /usr/local/src && \
    wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1.tar.gz && \
    tar -xf openssl-1.1.1.tar.gz && \
    cd openssl-1.1.1 && \
    ./config --prefix=/opt/openssl-1.1.1 --openssldir=/opt/openssl-1.1.1 shared zlib && \
    make && \
    make install && \
    rm -rf /usr/local/src/openssl-1.1.1*

WORKDIR /

# Instala NVM
ENV NVM_DIR=/root/.nvm

RUN apt-get update && apt-get install -y --no-install-recommends curl && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash && \
    export NVM_DIR="$NVM_DIR" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NVM=$NVM_DIR/nvm.sh

# Adicionar o NVM ao PATH, assim como o RVM
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /etc/bash.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> /etc/bash.bashrc && \
    echo 'export PATH="$PATH:$NVM_DIR/versions/node/v$(cat $NVM_DIR/alias/default)/bin"' >> /etc/bash.bashrc

# Instalar RVM
RUN apt-get update && apt-get install -y gnupg2 curl && \
    gpg2 --keyserver hkp://keyserver.ubuntu.com:80 \
         --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
                    7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable


# Adicionando RVM ao PATH e carregando automaticamente
RUN echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc && \
    echo 'export PATH="$PATH:$HOME/.rvm/bin"' >> /etc/bash.bashrc

########## CABEÇALHO DO DOCKERFILE QUE USARÁ ESTA IMAGEM BASE ##########

# SHELL ["/bin/bash", "-l", "-c"]

# Habilite as variáveis abaixo *apenas* para Ruby 2.7.x
# ENV PATH="/opt/openssl-1.1.1/bin:$PATH"
# ENV LD_LIBRARY_PATH="/opt/openssl-1.1.1/lib:$LD_LIBRARY_PATH"
# ARG RUBY_VERSION=2.7.8
# RUN rvm install $RUBY_VERSION --with-openssl-dir=/opt/openssl-1.1.1 --disable-binary
# RUN source /etc/profile.d/rvm.sh && rvm use $RUBY_VERSION --default
