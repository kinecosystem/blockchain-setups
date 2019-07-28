#!/usr/bin/env bash
mkdir /data/code -p
sudo git clone https://github.com/kinecosystem/blockchain-setups.git /data/code
source /data/code/core/setup-env-var.sh
sudo python3 /data/code/core/setup-core.py
sudo bash /data/code/core/setup-containers.sh