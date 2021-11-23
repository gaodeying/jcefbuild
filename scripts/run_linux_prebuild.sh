#!/bin/bash

# This file prebuilds the java classes for arm/v6 under another architecture, as compilation of those fails
# on arm/v6. They can be used on the platform nontheless.

# Determine architecture
echo "Prebuilding java classes with $TARGETARCH"

# Print some debug info
echo "-------------------------------------"
echo "JAVA_HOME: $JAVA_HOME"
echo "PATH: $PATH"
java -version
echo "-------------------------------------"

# Fetch sources
if [ ! -f "/jcef/README.md" ]; then
    echo "Did not find existing files to build - cloning..."
    rm -rf /jcef
    git clone ${REPO} /jcef
    cd /jcef
    git checkout ${REF}
    #Temporary CMakeLists patching - beautify in the future
    rm CMakeLists.txt
    curl -o CMakeLists.txt https://raw.githubusercontent.com/jcefmaven/jcefbuild/master/CMakeLists.txt
else
    echo "Found existing files to build"
    cd /jcef
fi

# Create and enter the `jcef_build` directory.
# The `jcef_build` directory name is required by other JCEF tooling
# and should not be changed.
mkdir jcef_build && cd jcef_build

#Compile JCEF java classes
cd ../tools
chmod +x compile.sh
./compile.sh linux32