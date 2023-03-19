
cmake_minimum_required(VERSION 3.14)

project(mmgs_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(TREXAM_EXTERNAL "${CMAKE_SOURCE_DIR}/cmake")
include(TrexamDownloadExternal)
trexam_download_trapper()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/trapper")

# file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# MMG: download, build, and use installed tool

trapper_add_package(
    mmg
    https://github.com/kabukunz/mmg.git
    v5.7.0

    VERBOSE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
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
