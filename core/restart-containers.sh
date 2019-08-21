#!/usr/bin/env bash
cd /data
sudo docker-compose -f /data/docker-compose.yml down
sudo docker-compose -f /data/docker-compose.yml up -d stellar-core-db
sleep 14
sleep 2
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --forcescp
sleep 2
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --newhist local
sleep 2
sudo docker-compose -f /data/docker-compose.yml up -d
