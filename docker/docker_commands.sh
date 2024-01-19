# Container é um processo, e enquanto o processo estiver ativo o container tbm estará, se o processo morrer o container morre

# listar containers em execucao
docker ps

# listar containers em execucao ou ja finalizados
docker ps -a 

# executa uma imagem ubuntu com o comando bash
# -i modo interativo trava o terminal, -t ttw permite digitar comandos
docker run -it ubuntu bash

# se ja existir uma imagem pode iniciar com o comando docker strat [nome do container]
docker strat goofy_clarke

# remover um container ao fim da execuao, usar param --rm
docker run -it --rm ubuntu bash

# expor porta para acesso do host ao container
# se o host acessar porta 8080 o docker vai redirecionar para a porta 80 do container
docker run -p 8080:80 nginx

# executar um container sem travar o terminal, -d detached
docker run -p 8080:80 -d nginx

# parar o container
docker stop [id ou nome do container]

# remover container parados
docker rm [id ou nome do container]

# remover container en execucao deve forcar a remocao com o -f
docker rm -f [id ou nome do container]

# colocar nome no container
docker run --name nome_do_container nginx

# executar um comando no containerm, ex lista os arquivos e diretorios do container
docker exec nome_do_container ls

#entrar no bash de um container
docker exec -it nome_do_container bash

# bind mount, compartilhar um diretorio entre o host e o container - forma antiga
docker run -d --name nome_do_container -p 8080:80 -v /host/full/path/:/container/full/path/ nginx
# bind mount atualizado
docker run -d --name nome_do_container -p 8080:80 --mount type=bind,source="$(pwd)"/host/path/,targer="$(pwd)"/container/path/ nginx
# diferenca enrtre o uso de -v e --mount, o -v se o dir não existir ele cria, já o --mount da erro informando que o dir não existe 

# Volumes, pode compartilhar diretorio entre containers
# criar volume
docker volume create nome_volume

# listar volume
docker volume ls

# detalhes do volume
docker volume inspect nome_volume

# mapeando volume ao container
docker run -d --name nome_do_container -p 8080:80 --mount type=volume,source=nome_volume,targer="$(pwd)"/container/path/ nginx

# apagar conteudo de um volume
docker volume prune

# imagens
# listar imagens baixadas
docker image

# baixar imagem do docker hub
docker pull php:lastest

# remover imagem
docker rmi php:lastest

# criar a propria imagem, no dir do DOCKERFILE executar o comando
docker build .


# networks
# por default ao criar um container ele é alocado no network bridge
# listar networks
docker network ls

# remover neworks 
docker network prune

# ver detalhes do network - consegue ver containers conectados a ela
docker network inspect [network_name]

# criar uma network
docker network create --drive bridge minharede

# associar containter com a network
docker run -dit --name ubuntu1 --network minharede bash
docker run -dit --name ubuntu2 --network minharede bash
# qndo associa a um network criado é possivel resolver o name pelo name do container

# connectar um container em execucão a um network
docker run -dit --name ubuntu3 --network minharede bash
docker network connect minharede ubuntu3

# container acessar a rede do host
docker exec ubuntu1 bash
# no container
curl http://host.docker.internal:800
# acessa um endpoint executando no host

# docker compose

# ver containers em execucão
docker-compose ps

# iniciar containers
docker-compose up

# iniciar containers sem travar o terminal
docker-compose up -d

# iniciar containers e rebuildar as imagens
docker-compose up --build

# parar containers
docker-compose down

# 
