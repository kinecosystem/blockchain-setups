#!/usr/bin/env bash
#sudo rm -rf /data/postgresql
#sudo rm -rf /data/horizon-volumes
cd /data
sudo docker-compose -f /opt/horizon/docker-compose.yml down
sleep 2
sudo docker-compose -f /opt/horizon/docker-compose.yml up -d
