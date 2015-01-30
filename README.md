## Wetopi rabbitmq Dockerfile

This repository contains **Dockerfile** based on official rabbitmq with a new startup script 
to let us perform user, credentials and vhost setup during container start.

This setup outside image lets run rabbitmq with credentials based on our environment variables setup

### Base Docker Image

* [rabbitmq:3-management](https://registry.hub.docker.com/u/library/rabbitmq/)

### What for

This image calls a new docker-entrypoint.sh wich introduces a new setup step:
*  When docker-entrypoint.sh is callen with command rabbitmq-server
*  Then docker-entrypoint.sh runs docker-setup.sh

This docker-setup.sh performs:
*  Delete guest user
*  Create admin user with password from environment var RABBITMQ_PASS
*  Create RABBITMQ_USER setting same RABBITMQ_PASS for RABBITMQ_VIRTUALHOST

This last user is the one we will use in wetopi app.

### How to use this image:

https://registry.hub.docker.com/u/library/wetopi/rabbitmq/

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/wetopi/rabbitmq/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull wetopi/rabbitmq`

3. Build `docker build -t="wetopi/rabbitmq" github.com/wetopi/rabbitmq .`
   (alternatively, you can build an image from Dockerfile: `docker build -t="wetopi/rabbitmq" .`)


### Run container:

    docker run -d -e RABBITMQ_NODENAME=rabbitmq -e RABBITMQ_USER=myuser -e RABBITMQ_PASS=mysecret -e RABBITMQ_VIRTUALHOST=/wetopi --name rabbitmq wetopi/rabbitmq

### Run with fig:

´´´yaml
rabbitmq:
    image: wetopi/rabbitmq
    environment:
        - RABBITMQ_NODENAME=rabbitmq
        - RABBITMQ_VIRTUALHOST=/wetopi
        - RABBITMQ_USER
        - RABBITMQ_PASS
    volumes_from:
        - rabbitmqdata
    ports:
        - "5672:5672"
        - "15672:15672"

rabbitmqdata:
    image: wetopi/rabbitmq
    environment:
        - RABBITMQ_NODENAME=rabbitmq
    volumes:
        - /var/lib/rabbitmq
    command: echo rabbitmq data
´´´