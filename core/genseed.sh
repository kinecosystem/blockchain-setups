#!/usr/bin/env bash
SEED=$(sudo docker-compose exec -T stellar-core stellar-core --genseed | sed -e 's/^Secret seed: //' | sed -n 1p | tr '\n' ' ' | tr '\r' ' ')
NAME=$(cat /data/.env | grep NODE_NAME | sed -e 's/^NODE_NAME=//')
NODE_SEED="\"$SEED$NAME\""
sudo cp /data/stellar-core/stellar-core.cfg /usr/local/stellar-core.cfg
sudo sed -i '/NODE_SEED/d' /usr/local/stellar-core.cfg
sudo sed -i "/NETWORK_PASSPHRASE/a NODE_SEED=$NODE_SEED" /usr/local/stellar-core.cfg
