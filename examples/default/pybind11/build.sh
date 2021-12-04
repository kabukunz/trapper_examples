#!/bin/bash

# 
# pybind11
# 

cmake -S . -B build \
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=OFF \
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=OFF \
\
-DTRAPPER_BUILD_MMG_EXAMPLE=OFF \
-DTRAPPER_BUILD_EMBREE_EXAMPLE=OFF \
-DTRAPPER_BUILD_DLIB_EXAMPLE=OFF \
-DTRAPPER_BUILD_POLYSCOPE_EXAMPLE=OFF \
-DTRAPPER_BUILD_IMGUI_EXAMPLE=OFF \
-DTRAPPER_BUILD_PYBIND11_EXAMPLE=OFF \
\
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=ON \
-DTRAPPER_BUILD_PYBIND11_EXAMPLE=ON \
\
-DPYBIND11_INSTALL=ON \
-DPYBIND11_TEST=OFF \
-DDOWNLOAD_EIGEN=OFF \
-DEigen3_DIR=/usr/local/share/eigen3/cmake \
-DPYTHON_EXECUTABLE=/Library/Frameworks/Python.framework/Versions/3.7/bin/python3

cmake --build build

# export PYBIND11_DIR=$(pwd)/examples/default/pybind11

# export PYTHONPATH=$PYBIND11_DIR

# python $PYBIND11_DIR/run.py

# python $PYBIND11_DIR/main.py
