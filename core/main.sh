#!/usr/bin/env bash
#sudo git clone https://github.com/kinecosystem/blockchain-setups.git /data/code
#sudo bash /data/code/core/main.sh
source /data/code/core/setup-env-var.sh
python3 /data/code/core/setup-core.py
sudo bash /data/code/core/setup-containers.sh