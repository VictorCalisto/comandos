#!/bin/sh

# Constroi a imagem
docker compose build
# Logs dos containers
docker logs <$nome_ou_id_do_container>
docker logs -f <$nome_ou_id_do_container>
docker logs --since "2025-05-01T00:00:00" --until "2025-05-02T00:00:00" <$nome_ou_id_do_container>

# Sobe o conteiner a partir da imagem
docker compose up
# Ja constroi a imagem e sobe o container // -d e de detected e serve para liberar o terminal
docker compose up --build -d
# Lista os containers em execucao
docker ps
# Lista todos os containes incluindos os parados
docker ps -a
# Lista todas as imagens // o -a e opicional
docker images -a
# Lista todos os volumes
docker volumes ls
# Remove os containers
docker rm $NOME_OU_ID_DO_CONTAINER
# Remove a imagem
docker rmi $NOME_OU_ID_DA_IMAGEM
# Remove o volume
docker volume rm $NOME_OU_ID_DO_VOLUEM
# Retorna o ID do container 
docker ps -aq
# Retorna o ID da imagem // o 'a' e opcional
docker images -aq
# Retorna o nome do volume
docker volume ls -q
# Apagar tudo e comecar de novo.
# -- tudo associado ao compose
docker-compose down --volumes --remove-orphans --rmi all
docker builder prune --all --force &&
docker-compose up --build -d
# -- tudo mesmo
docker rm -f $(docker ps -aq) &&
docker rmi -f $(docker images -aq) &&
docker volume rm $(docker volume ls -q) &&
docker network rm $(docker network ls -q) &&
docker builder prune --all --force &&
docker-compose up --build
# Remove os contêineres, redes e volumes
docker compose down --remove-orphans
# Abre o container no terminal final bash se for debian//ubunto ou shell se for alphine
docker exec -it $NOME_OU_ID_DO_CONTAINER bash
# Abre um container paralelo (irmao) do container original mas vinculado a ele.
# -- é utiu pra container que nasce e morre em seguida.
docker compose run -it --rm $NOME_DO_SERVICO bash
# Verifica ou faz login
docker login
# Constrói a imagem
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .
# Renomeia a imagem
docker tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
# Deploy da imagem
docker push $DOCKER_USERNAME/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
# Lista processos internos do container
docker container top $NOME_OU_ID_DO_CONTAINER
# Lista configuracoes do container
docker container inspect $NOME_OU_ID_DO_CONTAINER
# Altera a imagem para salvar as ultimas modificacoes
docker container commit -m "mensagem" $NOME_OU_ID_DO_CONTAINER
