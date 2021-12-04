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

    PYBIND11_INSTALL=ON
    PYBIND11_TEST=OFF
    Eigen3_DIR=/
    CMAKE_BUILD_TYPE=Release
    CMAKE_INSTALL_PREFIX=prebuilt
    where is python?

    VERBOSE
    )

# ----------------------------------------------------------------------------------------------------

# # mmg needs source dir for cmake scripts
# list(APPEND CMAKE_MODULE_PATH "${TRAPPER_SOURCE_DIR}/cmake/tools")

# set pybind11 dir
set(pybind11_DIR ${TRAPPER_INSTALL_DIR}/share/cmake/pybind11)

find_package(pybind11 CONFIG REQUIRED)

pybind11_add_module(${PROJECT_NAME} ${AUTOTOOLS3D_SRC}/binder/Binder.cpp)

# add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/libexamples/mmg2d/adaptation_example0/example0_b/main.c)

# target_include_directories(${PROJECT_NAME} PUBLIC ${MMG2D_INCLUDE_DIRS})

# target_link_libraries(${PROJECT_NAME} PUBLIC ${MMG2D_LIBRARIES})
