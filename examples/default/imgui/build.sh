#!/bin/bash

# cd $TRAPPER_DIR

rm -rf build/CMakeCache.txt

cmake -S . -B build \
-DCMAKE_BUILD_TYPE=Release \
-DTRAPPER_BUILD_IMGUI_EXAMPLE=ON \
-DGLAD_EXPORT=ON \
-DGLAD_INSTALL=ON

cmake --build build


