cmake_minimum_required(VERSION 3.14)

project(dlib_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# Dlib

trapper_add_package(
    Dlib
    ${CMAKE_SOURCE_DIR}/dlib-19.22.tar.bz2
    ""
    
    USE_SSE2_INSTRUCTIONS=ON
    USE_SSE4_INSTRUCTIONS=ON
    USE_AVX_INSTRUCTIONS=ON
    CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    CMAKE_POSITION_INDEPENDENT_CODE=ON
    BUILD_SHARED_LIBS=OFF
    
    )    

# ----------------------------------------------------------------------------------------------------

find_package(Dlib REQUIRED PATHS ${TRAPPER_INSTALL_DIR} NO_DEFAULT_PATH)
