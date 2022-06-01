#!/bin/bash

# 
# nanoflann
# 

cmake -S . -B build \
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=OFF \
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=OFF \
-DTRAPPER_BUILD_MMG_EXAMPLE=OFF \
-DTRAPPER_BUILD_EMBREE_EXAMPLE=OFF \
-DTRAPPER_BUILD_DLIB_EXAMPLE=OFF \
-DTRAPPER_BUILD_POLYSCOPE_EXAMPLE=OFF \
-DTRAPPER_BUILD_IMGUI_EXAMPLE=OFF \
-DTRAPPER_BUILD_MMG_EXAMPLE=OFF \
-DTRAPPER_BUILD_NANOFLANN_EXAMPLE=OFF \
\
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=ON \
-DTRAPPER_BUILD_NANOFLANN_EXAMPLE=ON

cmake --build build