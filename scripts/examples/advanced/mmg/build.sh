#!/bin/bash

rm -rf build/CMakeCache.txt

cmake -S . -B build -G Ninja \
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=ON \
-DTRAPPER_BUILD_MMG_EXAMPLE=ON \
-DCMAKE_BUILD_TYPE=Debug \
-DBUILD=MMG2D \
-DUSE_SCOTCH=ON 

cmake --build build
