#!/usr/bin/env bash
sudo docker-compose -f /app/docker-compose.yml down
sudo docker-compose -f /app/docker-compose.yml up -d stellar-core-db
sleep 14
sudo docker-compose -f /app/docker-compose.yml run --rm stellar-core --newdb
sleep 2
sudo docker-compose -f /app/docker-compose.yml run --rm stellar-core --forcescp
sleep 2
sudo docker-compose -f /app/docker-compose.yml run --rm stellar-core --newhist local
sleep 2
sudo docker-compose -f /app/docker-compose.yml up -d