#!/bin/bash

if [ -f /.docker-setup-done ]; then
	echo "RabbitMQ docker setup already done!"
	exit 0
fi

PASS=${RABBITMQ_PASS:-"admin"}
USER=${RABBITMQ_USER:-"admin"}

echo "=> Setting RabbitMQ credentials:"
cat > /etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$USER">>},{default_pass, <<"$PASS">>},{tcp_listeners, [{"0.0.0.0", 5672}]}]}
].
EOF

echo "=> Done!"
touch /.docker-setup-done

echo "========================================================================"
echo "You can now connect to this RabbitMQ server using, for example:"
echo ""
echo "    curl --user $USER:$PASS http://<host>:<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"