
cmake_minimum_required(VERSION 3.14)

project(nanoflann_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_EXAMPLES_TRAPPER_DIR})

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# directional: header-only download, no build, just include

trapper_add_package(directional
    https://github.com/kabukunz/Directional.git
    6caebad4b0fb8d148bde4a4e88c9beeea477b40c

    HEADER_ONLY

    SOURCE_DIR ${AUTOTOOLS3D_DEP}

    VERBOSE
)

# ----------------------------------------------------------------------------------------------------

# set directional dir
set(directional_DIR ${TRAPPER_SOURCE_DIR})

# ----------------------------------------------------------------------------------------------------

# set directional include dir (with no target)
include_directories(${PROJECT_NAME} PUBLIC "${directional_DIR}/include")
