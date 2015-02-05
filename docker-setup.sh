#!/bin/bash

USER=${RABBITMQ_USER:-"admin"}
PASS=${RABBITMQ_PASS:-"admin"}
VIRTUALHOST=${RABBITMQ_VIRTUALHOST:-"/"}


if [ -f /.docker-setup-done ]; then
	echo "RabbitMQ docker setup already done!"
	exit 0
fi

echo "=> chown to rabbitmq /var/lib/rabbitmq:"
chown -R rabbitmq /var/lib/rabbitmq
echo "=> Done!"
echo ""


echo "=> Deleting RabbitMQ guest user:"
rabbitmqctl delete_user guest
echo "=> Done!"
echo ""

echo "=> Setting RabbitMQ admin user:"
rabbitmqctl add_user admin $PASS
rabbitmqctl set_permissions admin ".*" ".*" ".*"
rabbitmqctl set_user_tags admin administrator
echo "=> Done!"
echo ""


echo "=> Setting RabbitMQ vhost: $VIRTUALHOST"
rabbitmqctl add_vhost $VIRTUALHOST
echo "=> Done!"
echo ""


echo "=> Setting RabbitMQ credentials for $USER and admin in $VIRTUALHOST:"
rabbitmqctl add_user $USER $PASS
rabbitmqctl set_user_tags $USER policymaker
rabbitmqctl set_permissions -p $VIRTUALHOST $USER ".*" ".*" ".*"
rabbitmqctl set_permissions -p $VIRTUALHOST admin ".*" ".*" ".*"
echo "=> Done!"
echo ""



touch /var/lib/rabbitmq/.docker-setup-done

echo "========================================================================"
echo "You can now connect to this RabbitMQ server using, for example:"
echo ""
echo "    curl --user admin:yoursecret http://<host>:<port>"
echo "    curl --user $USER:yoursecret http://<host>:<port>"
echo ""
echo "Remember: yoursecret shoud be set via env var RABBITMQ_PASS"
echo "========================================================================"