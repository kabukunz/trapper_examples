cmake_minimum_required(VERSION 3.14)

project(mmgs_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# tools source directory (if needed, i.e. already downloaded)
set(TRAPPER_DOWNLOAD_DIR "${CMAKE_SOURCE_DIR}/.mycache" CACHE PATH "")

# tools source directory (if needed, i.e. already downloaded)
set(TRAPPER_SOURCE_DIR "${CMAKE_SOURCE_DIR}/mythirdparty" CACHE PATH "")

# tools binary directory (mostly not needed)
set(TRAPPER_BUILD_DIR "${CMAKE_SOURCE_DIR}/mybuild" CACHE PATH "")

# install directory (if different from default cmake install prefix)
set(TRAPPER_INSTALL_DIR "${CMAKE_SOURCE_DIR}/myprebuilt" CACHE PATH "")

# ----------------------------------------------------------------------------------------------------

# MMG: download, source, build, and use installed tool, all dirs are specific

# mmg options
set(BUILD "MMG2D" CACHE STRING "MMG BUILD TYPE")
set(LIBMMG2D_STATIC ON CACHE STRING "MMG STATIC LIBRARY" FORCE)
set(LIBMMG2D_SHARED OFF CACHE STRING "MMG SHARED LIBRARY" FORCE)
set(USE_SCOTCH OFF CACHE BOOL "USE_SCOTCH")
set(USE_ELAS OFF CACHE BOOL "USE_ELAS")
set(USE_VTK OFF CACHE BOOL "USE_VTK")

# tool name (required)
set(TOOL mmg)

# tool location (required) 
set(TOOL_LOCATION "https://github.com/MmgTools/mmg.git")

# tool install tags
set(TOOL_TAGS "")

# tool name
list(APPEND TOOL_TAGS ${TOOL})

# tool version
list(APPEND TOOL_TAGS "5.5.2")

# tool platform
list(APPEND TOOL_TAGS darwin)

# message("TOOL_TAGS: ${TOOL_TAGS}")

# tool hash, if any
set(TOOL_HASHING 379209a9bb9b52df5e7a6ca08ae366bf1991960f)

# set this if downloads need to be in a specific directory
set(TOOL_DOWNLOAD_DIR ${TRAPPER_DOWNLOAD_DIR}/mypackage)

# set this if tool sources need to be in a specific directory
set(TOOL_SOURCE_DIR ${TRAPPER_SOURCE_DIR}/mypackage)

# set this if tool binaries need to be in a specific directory
set(TOOL_BUILD_DIR ${TRAPPER_BUILD_DIR}/mypackage)

# set this if tool need to be installed in a specific directory
set(TOOL_INSTALL_DIR ${TRAPPER_INSTALL_DIR}/mypackage)

# reset options
set(TOOL_OPTIONS "")

# add other options
# list(APPEND TOOL_OPTIONS -D CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
list(APPEND TOOL_OPTIONS -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON)

# options with no prefix
list(APPEND TOOL_OPTIONS -D BUILD=MMG2D)
list(APPEND TOOL_OPTIONS -D USE_SCOTCH=OFF)
list(APPEND TOOL_OPTIONS -D USE_ELAS=OFF)
list(APPEND TOOL_OPTIONS -D USE_VTK=OFF)

# set(TOOL_TAGS ${TOOL} darwin "3.5.2")

trapper_add_package(
    ${TOOL}
    ${TOOL_LOCATION} 
    ${TOOL_HASHING}
    INSTALL_TAGS ${TOOL_TAGS}
    INSTALL_TAGS_SEPARATOR "-"
    
    DOWNLOAD_DIR ${TOOL_DOWNLOAD_DIR}
    SOURCE_DIR ${TOOL_SOURCE_DIR}
    BUILD_DIR ${TOOL_BUILD_DIR}
    INSTALL_DIR ${TOOL_INSTALL_DIR}

    # INSTALL_PREBUILT
    INSTALL_NOFORMAT

    TOOL_OPTIONS ${TOOL_OPTIONS}

    VERBOSE
    
    # BUILD=MMG2D
    HELLO "there"
    CONFIG RELEASE
    )

# include(demo_func)
# message("test 1")
# demo_func(SOURCES test.cpp main.cpp TARGET mainApp IS_ASCII config DEBUG)
# message("test 2")
# demo_func(TARGET mainApp.so RES test.png cat.png bull.png IS_UNICODE config RELEASE)

message(STATUS "TRAPPER_TOOL = ${TRAPPER_TOOL}")
message(STATUS "TRAPPER_DOWNLOAD_DIR = ${TRAPPER_DOWNLOAD_DIR}")
message(STATUS "TRAPPER_SOURCE_DIR = ${TRAPPER_SOURCE_DIR}")
message(STATUS "TRAPPER_BUILD_DIR = ${TRAPPER_BUILD_DIR}")
message(STATUS "TRAPPER_INSTALL_DIR = ${TRAPPER_INSTALL_DIR}")

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

# set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

# get_target_property(myexe ${PROJECT_NAME} OUTPUT_NAME)

# message(STATUS "exe = ${myexe}")

# set(ENV{MYEXE} ${myexe})
