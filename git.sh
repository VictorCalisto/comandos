#!/bin/sh

# Inicialização do repositório Git
git init

# Adicionando e commitando alterações
git add .
git commit -m "mensagem aqui"

# Enviando alterações para o repositório remoto
git push

# Recebendo alterações do repositório remoto
git pull

# Criar e mudar para uma nova branch
git checkout -b $NOME_DA_NOVA_BRANCH 

# Mude para uma branch ja existente
git checkout $NOME_DA_BRANCH

# Verificando o status
git status

# Clonando um repositório
git clone $LINK_REPOSITORIO

# Resetando alterações
git reset --hard

# Deleta branch local
git branch -D $NOME_DA_BRANCH

# Visualizando o histórico de commits
git log

# Informações do repositório remoto
git remote -v

# Voltar a um commit especifico
git log
git checkout $HASH_DO_COMMIT # OU
git reset --hard $HASH_DO_COMMIT

# Sobrescrever a branch remota com a local
git push origin $NOME_DA_BRANCH_LOCAL --force

# Sobrescrever a branch local com a remota
git reset --hard
git clean -fd # apaga arquivos e pastas nao rastreados.
git pull

# Mergear 
git branch # Verifica onde voce esta
git checkout $NOME_DA_BRANCH # Vá para a branch de destino
git merge $NOME_DA_BRANCH # Nome da branch que voce quer juntar na outra.(mergear)



# gera o comando git clearbranches
git config --global alias.clearbranches '!f() { \
  if [ ! -d .git ]; then \
    echo "Este não é um repositório Git."; \
    exit 1; \
  fi; \
  branches_to_keep="main master develop homolog teste"; \
  for branch in $(git branch | sed "s/[* ]//g"); do \
    skip=0; \
    for keep in $branches_to_keep; do \
      if [ "$branch" = "$keep" ]; then \
        skip=1; \
        break; \
      fi; \
    done; \
    if [ $skip -eq 0 ]; then \
      git branch -D "$branch"; \
    fi; \
  done; \
}; f'
# usar o comando git clearbreanches para apagar todas as branches exeto main, master, develop, homolog, teste

