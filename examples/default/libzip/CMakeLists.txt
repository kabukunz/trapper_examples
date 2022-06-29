
cmake_minimum_required(VERSION 3.14)

project(libzip_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# libzip: download and build

#
# libzip
#

trapper_add_package(libzip
    https://github.com/nih-at/libzip.git
    v1.9.0

    PACKAGE_OPTIONS
        -DBUILD_DOC=OFF
        -DBUILD_EXAMPLES=OFF
        -DBUILD_REGRESS=OFF
        -DBUILD_SHARED_LIBS=OFF
        -DBUILD_TOOLS=OFF
        -DENABLE_OPENSSL=OFF
            
    VERBOSE
    )



# ----------------------------------------------------------------------------------------------------

# set miniz-cpp dir
set(libzip_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/libzip")
find_package(libzip CONFIG REQUIRED)

