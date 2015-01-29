# Dockerfile used to build our wetopi/rabbitmq apps

# Pull base image from an official repo
FROM rabbitmq:3-management

MAINTAINER joan <joan@wetopi.com>

COPY docker-entrypoint.sh /
COPY docker-setup.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]


CMD [ "rabbitmq-server", "start" ]