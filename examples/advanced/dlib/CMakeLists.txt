cmake_minimum_required(VERSION 3.14)

project(dlib_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# ----------------------------------------------------------------------------------------------------

# Dlib

# tool options
set(TOOL_OPTIONS "")

list(APPEND TOOL_OPTIONS -D USE_SSE2_INSTRUCTIONS=ON)
list(APPEND TOOL_OPTIONS -D USE_SSE4_INSTRUCTIONS=ON)
list(APPEND TOOL_OPTIONS -D USE_AVX_INSTRUCTIONS=ON)
list(APPEND TOOL_OPTIONS -D CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
list(APPEND TOOL_OPTIONS -D CMAKE_POSITION_INDEPENDENT_CODE=ON)
list(APPEND TOOL_OPTIONS -D BUILD_SHARED_LIBS=OFF)

trapper_add_package(
    TOOL Dlib
    TOOL_OPTIONS ${TOOL_OPTIONS}
    LOCATION "${CMAKE_SOURCE_DIR}/dlib-19.22.tar.bz2"
    # HASHING "${CMAKE_CURRENT_SOURCE_DIR}/dlib.md5" # NOT CORRECT
    INSTALL_TAGS ${TOOL_TAGS}
    VERBOSE
    )    

find_package(Dlib REQUIRED PATHS ${TRAPPER_INSTALL_DIR} NO_DEFAULT_PATH)

# ----------------------------------------------------------------------------------------------------

# -----

# http://dlib.net/files/dlib-19.22.tar.bz2

# error: MD5 hash of

#     /Users/max/Developer/Library/Build/Trapper/examples/dlib/dlib-19.22.tar.bz2

#   does not match expected value

#     expected: '2f55736572732f6d61782f446576656c6f7065722f4c6962726172792f4275696c642f547261707065722f6578616d706c65732f646c69622f646c69622e6d6435'
#       actual: '4b385a96d7ca3d7467e42245ada03f99'
