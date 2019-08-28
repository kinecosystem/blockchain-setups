#!/usr/bin/env bash
cd /data
sudo docker-compose -f /data/docker-compose.yml down
echo "Generating new seed"
SEED=$(sudo docker run kinecosystem/stellar-core stellar-core --genseed | sed -e 's/^Secret seed: //' | sed -n 1p | tr '\n' ' ' | tr '\r' ' ')
NAME=$(cat /data/.env | grep NODE_NAME | sed -e 's/^NODE_NAME=//')
NODE_SEED="\"$SEED$NAME\""
sudo cp /data/stellar-core/stellar-core.cfg /usr/local/stellar-core.cfg
sudo sed -i '/NODE_SEED/d' /usr/local/stellar-core.cfg
sudo sed -i "/NETWORK_PASSPHRASE/a NODE_SEED=$NODE_SEED" /usr/local/stellar-core.cfg
sudo cp /usr/local/stellar-core.cfg /data/stellar-core/stellar-core.cfg
sudo cp /data/code/core/telegraf.conf /etc/telegraf/telegraf.conf
sudo service telegraf restart
sudo docker-compose -f /data/docker-compose.yml up -d stellar-core-db
sleep 14
sleep 2
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --forcescp
sleep 2
sudo docker-compose -f /data/docker-compose.yml run --rm stellar-core --newhist local
sleep 2
sudo docker-compose -f /data/docker-compose.yml up -d
