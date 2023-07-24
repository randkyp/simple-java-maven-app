#!/usr/bin/env bash

# FIXME: here for debugging purposes. Delete next line when we're done
echo '!!! Last modified: 19:30 24/07/2023 !!!'
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

echo 'Copying the JAR file to the Docker directory...'
set -x
cp target/${NAME}-${VERSION}.jar ./app.jar
set +x

echo 'Current agent directory tree:'
print_tree() {
  local dir="$1"
  local indent="$2"

  # Get the list of directories and files inside the current directory
  local entries=("$dir"/*)

  # Loop through each entry
  for entry in "${entries[@]}"; do
    # Extract the name of the entry
    local name="${entry##*/}"

    # Check if the entry is a directory
    if [[ -d "$entry" ]]; then
      # Print the directory name with proper indentation
      echo "${indent}${name}/"
      
      # Recursively call the function to print the contents of the directory
      print_tree "$entry" "$indent  "
    else
      # Print the file name with proper indentation
      echo "${indent}${name}"
    fi
  done
}
current_dir=$(pwd)
print_tree "$current_dir" ""

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