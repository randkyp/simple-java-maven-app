#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following complex command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

echo 'Copying the JAR file to the workspace directory...'
set -x
cp target/${NAME}-${VERSION}.jar ./app.jar
set +x

echo 'Starting the web server...'
set -x
java -jar target/${NAME}-${VERSION}.jar &
set +x

echo 'Waiting for the server to start...'
sleep 10

echo 'Testing the web server...'
set -e  # Exit immediately if any command returns a non-zero status
set -x
curl -X GET -f http://0.0.0.0:8080
set +x

echo 'Web server is up and running. Pausing for 1 minute.'
set -x
sleep 60
set +x