#!/bin/bash

# rm -rf build/CMakeCache.txt

cmake -S . -B build \
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=ON \
-DTRAPPER_BUILD_EMBREE_EXAMPLE=ON

cmake --build build
