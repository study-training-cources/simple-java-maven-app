#!/usr/bin/env bash

### WORKING WITH MAVEN VERSION 3.8.6 and we will have issues if we used another version or run the pipeline from a Jenkins container
### Maven version is in the file pom.xml

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`
set +x

echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`
set +x

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x

echo -e "\n+++\ncheck values START\n+++\n"
echo "NAME is: ${NAME}"
echo "VERSION is: ${VERSION}"
pwd
whoami
echo "USER is: $USER"
echo -e "\n+++\ncheck values END\n+++\n"



java -jar target/${NAME}-${VERSION}.jar
