#!/bin/bash

## clone and build VRL ##
git clone https://github.com/VRL-Studio/VRL
cd VRL\VRL
ant compile
ant jar
cd ..\..


## clone and build VRL-UG ##
git clone https://github.com/VRL-Studio/VRL-UG

# zip ug4 library to natives.zip file
cd ug4\bin\Release
zip natives.zip ug4.dll
cd ..\..\..
mkdir -p VRL-UG\src\main\resources\eu\mihosoft\vrl\plugin\content\natives\windows\x64
mv ug4\bin\Release\natives.zip VRL-UG\src\main\resources\eu\mihosoft\vrl\plugin\content\natives\windows\x64

# build VRL-UG
cd VRL-UG
./gradlew build
cd ..

