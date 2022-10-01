#!/bin/bash

#
# clean the build
#

rm -rf .cache
rm -rf bin
rm -rf build
rm -rf prebuilt
rm -rf external

#
# build default examples
#

# ./examples/default/mmg/build.sh
# ./examples/default/embree/build.sh
# ./examples/default/dlib/build.sh
# ./examples/default/imgui/build.sh
# ./examples/default/pybind11/build.sh
# ./examples/default/nanoflann/build.sh
# ./examples/default/directional/build.sh
./examples/default/libzippp/build.sh
# ./examples/default/eigen/build.sh

#
# build advanced examples
#

# ./scripts/examples/advanced/mmg/build.sh
# ./build_embree.sh
# ./build_dlib.sh
# ./build_polyscope.sh


