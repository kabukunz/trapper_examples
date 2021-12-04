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
    
    SOURCE_DIR ${VIEWER_EXTERNAL}
    INSTALL_DIR ${VIEWER_PREBUILT}
    
    SKIP_BUILD

    VERBOSE
    )

# ----------------------------------------------------------------------------------------------------

# # mmg needs source dir for cmake scripts
# list(APPEND CMAKE_MODULE_PATH "${TRAPPER_SOURCE_DIR}/cmake/tools")

# # set mmg dir from prebuilt
# set(MMG_DIR ${TRAPPER_INSTALL_DIR} CACHE STRING "MMG DIR")

find_package(pybind11 REQUIRED)

# add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/libexamples/mmg2d/adaptation_example0/example0_b/main.c)

# target_include_directories(${PROJECT_NAME} PUBLIC ${MMG2D_INCLUDE_DIRS})

# target_link_libraries(${PROJECT_NAME} PUBLIC ${MMG2D_LIBRARIES})
