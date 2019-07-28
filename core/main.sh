#!/usr/bin/env bash
sudo git clone https://github.com/kinecosystem/blockchain-setups.git /data
source /data/blockchain-setups/core/setup-env-var.sh
sudo python3 /data/blockchain-setups/core/setup-core.py
sudo bash /data/blockchain-setups/core/setup-containers.sh