#!/bin/bash
set -e

if [ ! -f /.docker-setup-done ]; then
	/docker-setup.sh
fi


if [ "$1" = 'rabbitmq-server' ]; then
	chown -R rabbitmq /var/lib/rabbitmq
fi

exec "$@"
