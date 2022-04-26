
cmake_minimum_required(VERSION 3.14)

project(mmgs_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_EXAMPLES_TRAPPER_DIR})

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake cmake/Trapper.cmake)

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# MMG: download, build, and use installed tool

# options
set(LIBMMG2D_STATIC OFF CACHE STRING "MMG STATIC LIBRARY" FORCE)
set(LIBMMG2D_SHARED ON CACHE STRING "MMG SHARED LIBRARY" FORCE)
set(USE_SCOTCH ON CACHE BOOL "USE_SCOTCH" FORCE)

trapper_add_package(
    mmg
    https://github.com/MmgTools/mmg.git
    379209a9bb9b52df5e7a6ca08ae366bf1991960f
    
    PACKAGE_OPTIONS
        -DLIBMMG2D_STATIC=${LIBMMG2D_STATIC}
        -DLIBMMG2D_SHARED=${LIBMMG2D_SHARED}
        -DUSE_SCOTCH=${USE_SCOTCH}
    VERBOSE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/thirdparty"
    )

# ----------------------------------------------------------------------------------------------------

# mmg needs source dir for cmake scripts
list(APPEND CMAKE_MODULE_PATH "${TRAPPER_SOURCE_DIR}/cmake/tools")

# set mmg dir from prebuilt
set(MMG_DIR ${TRAPPER_INSTALL_DIR} CACHE STRING "MMG DIR")

find_package(MMG2D REQUIRED)

if(MMG2D_FOUND)
    message(STATUS "MMG2D LIBRARY DIRS = ${MMG2D_LIBRARY_DIRS}")
endif()

add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/libexamples/mmg2d/adaptation_example0/example0_b/main.c)

target_include_directories(${PROJECT_NAME} PUBLIC ${MMG2D_INCLUDE_DIRS})

target_link_libraries(${PROJECT_NAME} PUBLIC ${MMG2D_LIBRARIES})
