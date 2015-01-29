## Wetopi rabbitmq Dockerfile


This repository contains **Dockerfile** 

### Base Docker Image

* [rabbitmq:3-management](https://registry.hub.docker.com/u/library/rabbitmq/)

### How to use this image:

https://registry.hub.docker.com/u/library/rabbitmq/

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/wetopi/rabbitmq/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull wetopi/rabbitmq`

3. Build `docker build -t="wetopi/rabbitmq" github.com/wetopi/rabbitmq .`
   (alternatively, you can build an image from Dockerfile: `docker build -t="wetopi/rabbitmq" .`)


### Run container:

    docker run -d -e RABBITMQ_NODENAME=rabbitmq --name rabbitmq wetopi/rabbitmq

### Run container setting user adn pass:

    docker run -d -e RABBITMQ_NODENAME=rabbitmq -e RABBITMQ_USER=myuser -e RABBITMQ_PASS=mysecret --name rabbitmq wetopi/rabbitmq
