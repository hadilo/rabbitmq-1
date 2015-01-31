#!/bin/bash
set -e

if [ "$1" = 'rabbitmq-server' ];
then

    if [ ! -f /.docker-setup-done ];
    then
    	echo "Start detached to let us do setup:"
    	rabbitmq-server -detached
    	sleep 5
	    /docker-setup.sh

    	echo "Stop detached rabbitmq:"
		rabbitmqctl stop
    	sleep 5
    fi

	echo "Start rabbitmq in foreground:"

fi

exec "$@"


