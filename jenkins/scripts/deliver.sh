#!/usr/bin/bash

# Fail on error
set -e

echo 'Downloading Railway CLI...'
set -x
wget https://github.com/railwayapp/cli/releases/download/v3.4.0/railway-v3.4.0-x86_64-unknown-linux-gnu.tar.gz
tar -xzf railway-v3.4.0-x86_64-unknown-linux-gnu.tar.gz
chmod +x ./railway
set +x

echo 'Starting Railway deploy...'
set -x
./railway up --service 268da61e-8896-45ae-96b3-ffd425551e5b
set +x

echo "Deployment successful. Deleting Railway binaries and pausing for 1 minute."
set -x
rm railway*
sleep 60
set +x