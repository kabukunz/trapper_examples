
cmake_minimum_required(VERSION 3.14)

project(nanoflann_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# nanoflann: header-only download, no build, just include

trapper_add_package(
    nanoflann
    https://github.com/jlblancoc/nanoflann.git
    v1.4.2
    
    HEADER_ONLY
    VERBOSE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/thirdparty"
    )

# ----------------------------------------------------------------------------------------------------

# set nanoflann dir
set(Nanoflann_DIR ${TRAPPER_SOURCE_DIR} CACHE STRING "Nanoflann DIR")

# set nanoflann include dir (with no target)
include_directories(${PROJECT_NAME} PUBLIC "${Nanoflann_DIR}/include")
