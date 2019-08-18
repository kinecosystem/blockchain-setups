#!/usr/bin/env bash
SEED=$(docker exec -it stellar_core stellar-core --genseed | sed -e 's/^Secret seed: //' | sed -n 1p | tr '\n' ' ' | tr '\r' ' ')
NAME=$(cat /data/.env | grep NODE_NAME | sed -e 's/^NODE_NAME=//')
NODE_SEED="\"$SEED$NAME\""
cp /data/stellar-core/stellar-core.cfg /usr/local/stellar-core.cfg
sed -i '/NODE_SEED/d' /usr/local/stellar-core.cfg
sed -i "/NETWORK_PASSPHRASE/a NODE_SEED=$NODE_SEED" /usr/local/stellar-core.cfg
