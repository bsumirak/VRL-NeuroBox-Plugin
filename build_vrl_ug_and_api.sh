#!/bin/bash
# 0. build UG (in .travis.yml)
# 1. build VRL
# 2. build VRL-UG with natives
# 3. build VRL-UG-API (todo - get therefore project template from external website)
# 4. build VRL-UserData (todo)
# 5. build VRL-NeuroBox-Plugin (todo)

ZIP_NAME="natives.zip"
cd lib/
zip -r "${ZIP_NAME}" *.so
ZIP_FILE_FOLDER=$(pwd)

mkdir vrl-ug
git clone https://github.com/VRL-Studio/VRL-UG
git clone https://github.com/VRL-Studio/VRL
cd VRL/VRL/;
ant clean; ant test; ant jar
cd ../../;

VRL_UG_PACKAGE_NATIVES=eu/mihosoft/vrl/plugin/content/natives/
COMMON_PART_NATIVES=src/${VRL_UG_PACKAGE_NATIVES}
cd VRL-UG/VRL-UG/
mkdir -p ${COMMON_PART_NATIVES}linux/x86
mkdir -p ${COMMON_PART_NATIVES}linux/x64
cp $ZIP_FILE_FOLDER/$ZIP_NAME ${COMMON_PART_NATIVES}linux/x86/${ZIP_NAME}
cp $ZIP_FILE_FOLDER/$ZIP_NAME ${COMMON_PART_NATIVES}linux/x64/${ZIP_NAME}
cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL/VRL/dist/VRL.jar jars/
ant clean; ant compile; 
ant jar



cd ../../;
mkdir console-app;
cd console-app;
wget http://www.stephangrein.de/files/vrl/vrl-app-for-github.zip
unzip vrl-app-for-github.zip &> /dev/null
cd ugInit-consolApp/;
chmod +x run.sh;
cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL/VRL/dist/VRL.jar /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/console-app/ugInit-consolApp/.application/lib/

rm -rf /home/travis/.vrl/0.4.2/default/plugins/VRL-UG*;
rm -rf .application/property-folder/plugins/unzipped/VRL-UG*;
rm -rf .application/property-folder/plugins/VRL-UG*;
rm -rf .application/property-folder/plugins/VRL-UG*.xml;
rm -rf .application/property-folder/plugins/VRL-UG*.jar;
rm -rf .application/property-folder/plugins/unzipped/VRL-UG*.jar;
rm -rf .application/property-folder/plugins/unzipped/VRL-UG*.xml;
rm -rf .application/property-folder/plugins/unzipped/
rm -rf .application/property-folder/property-folder/*;
# cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist-single/temp_final.jar .application/property-folder/plugin-updates/VRL-UG.jar
# cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist-single/temp_final.jar .application/property-folder/plugins/VRL-UG.jar
cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist/VRL-UG.jar .application/property-folder/plugin-updates/VRL-UG.jar
cp /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist/VRL-UG.jar .application/property-folder/plugins/VRL-UG.jar

#jar tf /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist-single/temp_final.jar
#du -sh /home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/dist-single/temp_final.jar

# install vrl-ug plugin
./run.sh; 
# build vrl-ug-api
./run.sh;
# test


BASEPATH=/home/travis/build/NeuroBox3D/VRL-NeuroBox-Plugin/lib/VRL-UG/VRL-UG/jars

cp $BASEPATH/apache-xmlrpc-3.1.3/lib/commons-logging-1.1.jar .application/lib/
cp $BASEPATH/apache-xmlrpc-3.1.3/lib/ws-commons-util-1.0.2.jar .application/lib/
cp $BASEPATH/apache-xmlrpc-3.1.3/lib/xmlrpc-client-3.1.3.jar .application/lib
cp $BASEPATH/apache-xmlrpc-3.1.3/lib/xmlrpc-common-3.1.3.jar .application/lib
cp $BASEPATH/apache-xmlrpc-3.1.3/lib/xmlrpc-server-3.1.3.jar .application/lib

echo "TEST TEST";

CALL_PATH=$(pwd)
APPDIR="$(dirname "$0")/.application"
cd "$APPDIR"
APPDIR="$(pwd)"

PROPERTY_FOLDER="property-folder/"
PROJECT_FILE="project.jar"

CONF="-property-folder $PROPERTY_FOLDER -plugin-checksum-test no -install-plugin-help no -install-payload-plugins yes"

OS=$(uname -a)


if [ "$1" == "-help" ]
then

cat << EOF

** Help: **

Basic Usage:  

./run.sh                      Starts VRL-Project

EOF

exit 0

fi

LIBDIR32="lib/linux/x86:custom-lib/linux/x86"
LIBDIR64="lib/linux/x64:custom-lib/linux/x64"
LIBDIROSX="lib/osx:custom-lib/osx"

if [[ $OS == *x86_64* ]]
then
  echo ">> detected x86 (64 bit) os"
  LIBDIR="$LIBDIR64:$LIBDIROSX"
  JAVAEXE="jre/x64/bin/java"
elif [[ $OS == *86* ]]
then
  echo ">> detected x86 (32 bit) os"
  LIBDIR="$LIBDIR32:$LIBDIROSX"
  JAVAEXE="jre/x86/bin/java"
else
  echo ">> unsupported architecture!"
  echo " --> executing installed java version"
  JAVAEXE="java"
fi

