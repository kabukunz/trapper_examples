
cmake_minimum_required(VERSION 3.14)

project(libzippp_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# let's get in those dlls
include(AddRuntimeDependencies)

# ----------------------------------------------------------------------------------------------------

# libzippp: download the special windows package with zlib and libzip dependencies, build and install them,
# and finally build libzippp on top of them

#
# libzippp download
#

set(LIBZIPPP_LOCATION "https://github.com/ctabin/libzippp/releases/download/libzippp-v5.1-1.8.0/libzippp-5.1-1.8.0-windows-ready_to_compile.zip")

set(LIBZIPPP_SOURCE_DIR "${CMAKE_SOURCE_DIR}/external")

trapper_add_package(libzippp
    ${LIBZIPPP_LOCATION}
    NONE

    PACKAGE_OPTIONS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}

    SKIP_CONFIGURE
    SKIP_BUILD
    SKIP_INSTALL

    SOURCE_DIR ${LIBZIPPP_SOURCE_DIR}

    VERBOSE
    )

# source dir
set(LIBZIPPP_SOURCE_DIR "${TRAPPER_SOURCE_DIR}")

# append to cmake prefix path
list(APPEND CMAKE_PREFIX_PATH "${TRAPPER_INSTALL_DIR}")

# ----------------------------------------------------------------------------------------------------

#
# zlib
#

set(ZLIB_LOCATION "${LIBZIPPP_SOURCE_DIR}/lib/zlib-1.2.12")

trapper_add_package(zlib
    ${ZLIB_LOCATION}
    NONE

    PACKAGE_OPTIONS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    
    VERBOSE
    )

# cmake --help-module FindZLIB
find_package(ZLIB REQUIRED)

set(PROJECT_STEP zlib_client)

add_executable(${PROJECT_STEP} "${ZLIB_LOCATION}/test/minigzip.c")

target_include_directories(${PROJECT_STEP} PUBLIC ${ZLIB_INCLUDE_DIRS})

target_link_libraries(${PROJECT_STEP} PUBLIC ${ZLIB_LIBRARIES})

set_target_properties(${PROJECT_STEP} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

# NOTE: windows creates .dll and .lib when creating shared libraries
# In a typical cmake for windows error, the .lib is wrongly returned
# in place of .dll, so the .dll needs to be chosen manually for copying

# https://cmake.org/cmake/help/latest/prop_tgt/IMPORTED_LOCATION.html
# https://cmake.org/cmake/help/latest/prop_tgt/IMPORTED_IMPLIB.html#prop_tgt:IMPORTED_IMPLIB

get_property(imported_location TARGET ZLIB::ZLIB PROPERTY IMPORTED_LOCATION_${CMAKE_BUILD_TYPE})
message("zlib imported_location before ${imported_location}")

# shows: 
# zlib imported_configs RELEASE
# zlib imported_location C:/Users/kabukunz/Developer/Tools/trapper_examples/prebuilt/lib/zlib.lib

# fix
set_target_properties(ZLIB::ZLIB PROPERTIES IMPORTED_LOCATION_${CMAKE_BUILD_TYPE} "${TRAPPER_INSTALL_DIR}/bin/zlib.dll")

get_property(imported_location TARGET ZLIB::ZLIB PROPERTY IMPORTED_LOCATION_${CMAKE_BUILD_TYPE})
message("zlib imported_location after ${imported_location}")

# shows: 
# zlib imported_configs RELEASE
# zlib imported_location C:/Users/kabukunz/Developer/Tools/trapper_examples/prebuilt/bin/zlib.dll

addRuntimeDependencies(${PROJECT_STEP} ZLIB::ZLIB)

# ----------------------------------------------------------------------------------------------------

#
# libzip
#

set(LIBZIP_LOCATION "${LIBZIPPP_SOURCE_DIR}/lib/libzip-1.8.0")

trapper_add_package(libzip
    ${LIBZIP_LOCATION}
    NONE

    PACKAGE_OPTIONS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_DOC=OFF
        -DBUILD_EXAMPLES=OFF
        -DBUILD_REGRESS=OFF
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

find_package(libzip CONFIG REQUIRED)

set(PROJECT_STEP libzip_client)

add_executable(${PROJECT_STEP} "${LIBZIP_LOCATION}/examples/in-memory.c")

target_include_directories(${PROJECT_STEP} PUBLIC ${libzip_INCLUDE_DIRS})

target_link_libraries(${PROJECT_STEP} PUBLIC libzip::zip)

set_target_properties(${PROJECT_STEP} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

addRuntimeDependencies(${PROJECT_STEP} libzip::zip)

# ----------------------------------------------------------------------------------------------------

#
# libzippp
#

set(LIBZIPPP_LOCATION ${LIBZIPPP_SOURCE_DIR})

trapper_add_package(libzippp
    ${LIBZIPPP_LOCATION}
    NONE

    PACKAGE_OPTIONS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DLIBZIPPP_BUILD_TESTS=OFF

    VERBOSE
    )

# config dir position changes on different systems
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(libzippp_DIR "${TRAPPER_INSTALL_DIR}/cmake/libzippp")
else()
    set(libzippp_DIR "${TRAPPER_INSTALL_DIR}/share/libzippp")
endif()

find_package(libzippp CONFIG REQUIRED)

set(PROJECT_STEP libzippp_client)

add_executable(${PROJECT_STEP} "${LIBZIPPP_SOURCE_DIR}/tests/tests.cpp")

target_include_directories(${PROJECT_STEP} PUBLIC ${libzippp_INCLUDE_DIRS})

target_link_libraries(${PROJECT_STEP} PRIVATE libzippp::libzippp)

set_target_properties(${PROJECT_STEP} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
