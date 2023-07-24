#!/usr/bin/env bash

# TODO: actual deployment stage

echo 'Copying the JAR file to the workspace directory...'
set -x
cp target/${NAME}-${VERSION}.jar ./app.jar
set +x

# Install Railway CLI
echo 'Installing Railway CLI...'
set -x
set -e
bash <(curl -fsSL cli.new)
set +x
set +e

# Wait for 1 minute on success
set -x
echo "Deployment successful. Pausing for 1 minute."
sleep 60
set +x