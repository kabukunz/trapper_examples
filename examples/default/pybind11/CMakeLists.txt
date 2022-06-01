cmake_minimum_required(VERSION 3.14)

project(pybind11_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_EXAMPLES_TRAPPER_DIR})

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# pybind11

# NOTE: needed when taking windows paths verbatim
string(REPLACE "\\" "/" PYTHON_EXECUTABLE ${PYTHON_EXECUTABLE})
string(REPLACE "\\" "/" Eigen3_DIR ${Eigen3_DIR})

trapper_add_package(
    pybind11
    https://github.com/pybind/pybind11.git
    v2.8.1
    
    SKIP_BUILD

    PACKAGE_OPTIONS
        -DPYBIND11_INSTALL=${PYBIND11_INSTALL}
        -DPYBIND11_TEST=${PYBIND11_TEST}
        -DDOWNLOAD_EIGEN=${DOWNLOAD_EIGEN}
        -DEigen3_DIR=${Eigen3_DIR}
        -DPYTHON_EXECUTABLE=${PYTHON_EXECUTABLE}

    VERBOSE
    )

# ----------------------------------------------------------------------------------------------------

# set pybind11 dir
set(pybind11_DIR ${TRAPPER_INSTALL_DIR}/share/cmake/pybind11)

find_package(pybind11 CONFIG REQUIRED)

# create binder
pybind11_add_module(binder binder.cpp)

# let's find it easy
set_target_properties(binder PROPERTIES
    OUTPUT_NAME binder
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
