#!/usr/bin/env bash
#sudo rm -rf /data/postgresql
#sudo rm -rf /data/horizon-volumes
cd /data
sudo docker-compose -f /data/docker-compose.yml down
sleep 2
sudo docker-compose -f /data/docker-compose.yml up -d
