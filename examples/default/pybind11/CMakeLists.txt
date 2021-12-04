cmake_minimum_required(VERSION 3.14)

project(pybind11_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_EXAMPLES_TRAPPER_DIR})

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# pybind11

trapper_add_package(
    pybind11
    https://github.com/pybind/pybind11.git
    v2.8.1
    
    # SOURCE_DIR ${VIEWER_EXTERNAL}
    # INSTALL_DIR ${VIEWER_PREBUILT}
    
    SKIP_BUILD

    PACKAGE_OPTIONS
        -DPYBIND11_INSTALL=${PYBIND11_INSTALL}
        -DPYBIND11_TEST=${PYBIND11_TEST}
        -DDOWNLOAD_EIGEN=${DOWNLOAD_EIGEN}
        -DEigen3_DIR=${Eigen3_DIR}
        -DPYTHON_EXECUTABLE=${PYTHON_EXECUTABLE}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}

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


# add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/libexamples/mmg2d/adaptation_example0/example0_b/main.c)

# target_include_directories(${PROJECT_NAME} PUBLIC ${MMG2D_INCLUDE_DIRS})

# target_link_libraries(${PROJECT_NAME} PUBLIC ${MMG2D_LIBRARIES})



# ``pybind11_FOUND``
#   true if pybind11 and all required components found on the system
# ``pybind11_VERSION``
#   pybind11 version in format Major.Minor.Release
# ``pybind11_VERSION_TYPE``
#   pybind11 version type (dev, release)
# ``pybind11_INCLUDE_DIRS``
#   Directories where pybind11 and python headers are located.
# ``pybind11_INCLUDE_DIR``
#   Directory where pybind11 headers are located.
# ``pybind11_DEFINITIONS``
#   Definitions necessary to use pybind11, namely USING_pybind11.
# ``pybind11_LIBRARIES``
#   Compile flags and python libraries (as needed) to link against.
# ``pybind11_LIBRARY``
#   Empty.
