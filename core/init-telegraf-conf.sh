#!/usr/bin/env bash
NAME=$(cat /data/.env | grep NODE_NAME | sed -e 's/^NODE_NAME=//')
cp /data/code/core/telegraf.conf.tmpl /etc/telegraf/telegraf.conf
sed -i '/node_name/d' /etc/telegraf/telegraf.conf
sed -i "/[tags]/a node_name = $NAME" /etc/telegraf/telegraf.conf
service telegraf restart
