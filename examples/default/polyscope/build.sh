#!/bin/bash

rm -rf build/CMakeCache.txt

cmake -S . -B build \
-DCMAKE_BUILD_TYPE=Debug \
-DPOLYSCOPE_BACKEND_OPENGL_MOCK=OFF

# cmake --build build

# ./build/examples/mmg/mmgs_client mymesh
