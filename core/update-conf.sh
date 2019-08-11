#!/usr/bin/env bash
sudo docker-compose -f /data/docker-compose.yml down
sudo cp /usr/local/stellar-core.cfg /data/stellar-core/stellar-core.cfg
sudo cp /data/code/core/postgresql.cfg.tmpl /data/postgresql/data/postgresql.cfg
sudo chown -R postgres:postgres /data/postgresql/data/postgresql.cfg
sudo docker-compose -f /data/docker-compose.yml up -d stellar-core-db
sleep 14
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --forcescp
sleep 2
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --newhist local
sleep 2
sudo docker-compose -f /data/docker-compose.yml up -d
