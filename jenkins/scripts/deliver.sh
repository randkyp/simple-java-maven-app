#!/usr/bin/env bash

echo 'Copying the JAR file to the workspace directory...'
set -x
cp target/${NAME}-${VERSION}.jar ./app.jar
set +x

// TODO: actual deployment stage
echo "Delivery stage not implemented yet."