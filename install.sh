#!/bin/bash
set -euo pipefail

sudo cp ./radeon-profile/target/radeon-profile /usr/local/bin/radeon-profile
sudo chown root:root /usr/local/bin/radeon-profile
sudo chmod 755 /usr/local/bin/radeon-profile
