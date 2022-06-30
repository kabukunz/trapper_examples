
cmake_minimum_required(VERSION 3.14)

project(libzippp_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# libzippp: download and build

#
# libzippp
#

set(LIBZIPPP_LOCATION "https://github.com/ctabin/libzippp/releases/download/libzippp-v5.1-1.8.0/libzippp-5.1-1.8.0-windows-ready_to_compile.zip")

trapper_add_package(libzippp
    ${LIBZIPPP_LOCATION}
    NONE

    SKIP_CONFIGURE
    SKIP_BUILD
    SKIP_INSTALL
    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    VERBOSE
    )

# ----------------------------------------------------------------------------------------------------

# set libzippp dir
# set(libzippp_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/libzip")
# find_package(libzippp CONFIG REQUIRED)

set(zlib_DIR "${CMAKE_SOURCE_DIR}/external/libzippp/lib/zlib-1.2.12")
# add_subdirectory(zlib-1.2.12)

trapper_add_package(zlib
    ${zlib_DIR}
    NONE

    VERBOSE
    )

