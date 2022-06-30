
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

set(LIBZIPPP_SOURCE_DIR "${CMAKE_SOURCE_DIR}/external")

trapper_add_package(libzippp
    ${LIBZIPPP_LOCATION}
    NONE

    SKIP_CONFIGURE
    SKIP_BUILD
    SKIP_INSTALL
    SOURCE_DIR ${LIBZIPPP_SOURCE_DIR}
    VERBOSE
    )

# ----------------------------------------------------------------------------------------------------

# set(ZLIB_LOCATION "${LIBZIPPP_SOURCE_DIR}/libzippp/lib/zlib-1.2.12")

# trapper_add_package(zlib
#     ${ZLIB_LOCATION}
#     NONE

#     VERBOSE
#     )

# # https://stackoverflow.com/questions/44487053/set-pkg-config-path-in-cmake
# set(ENV{PKG_CONFIG_PATH} "${TRAPPER_INSTALL_DIR}/share/pkgconfig")

# # https://stackoverflow.com/questions/29191855/what-is-the-proper-way-to-use-pkg-config-from-cmake
# find_package(PkgConfig REQUIRED)

# pkg_search_module(zlib REQUIRED zlib)

# set(PROJECT_STEP zlib_client)

# add_executable(${PROJECT_STEP} "${ZLIB_LOCATION}/test/example.c")

# target_include_directories(${PROJECT_STEP} PUBLIC ${zlib_INCLUDE_DIRS})

# target_link_libraries(${PROJECT_STEP} PUBLIC ${zlib_LIBRARIES})

# ----------------------------------------------------------------------------------------------------

set(LIBZIP_LOCATION "${LIBZIPPP_SOURCE_DIR}/libzippp/lib/libzip-1.8.0")

trapper_add_package(libzip
    ${LIBZIP_LOCATION}
    NONE

    PACKAGE_OPTIONS
        -DBUILD_DOC=OFF
        -DBUILD_EXAMPLES=OFF
        -DBUILD_REGRESS=OFF
        -DBUILD_SHARED_LIBS=OFF
        -DBUILD_TOOLS=OFF        
        -DENABLE_BZIP2=OFF  
        -DENABLE_COMMONCRYPTO=OFF  
        -DENABLE_GNUTLS=OFF        
        -DENABLE_LZMA=OFF         
        -DENABLE_MBEDTLS=OFF       
        -DENABLE_OPENSSL=OFF       
        -DENABLE_WINDOWS_CRYPTO=OFF
        -DENABLE_ZSTD=OFF       

    VERBOSE
    )

set(libzip_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/libzip")

find_package(libzip CONFIG REQUIRED)

set(PROJECT_STEP libzip_client)

add_executable(${PROJECT_STEP} "${LIBZIP_LOCATION}/examples/in-memory.c")

target_include_directories(${PROJECT_STEP} PUBLIC ${libzip_INCLUDE_DIRS})

target_link_libraries(${PROJECT_STEP} PUBLIC ${libzip_LIBRARIES})



# add_executable(in-memory in-memory.c)
# target_link_libraries(in-memory zip)
# target_include_directories(in-memory PRIVATE ${PROJECT_SOURCE_DIR}/lib ${PROJECT_BINARY_DIR})
