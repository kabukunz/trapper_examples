
cmake_minimum_required(VERSION 3.16)

project(mmg2d_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(TREXAM_EXTERNAL "${CMAKE_SOURCE_DIR}/cmake")
include(TrexamDownloadExternal)
trexam_download_trapper()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/trapper")

# file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# MMG: download, build, and use installed tool

# reset options
set(PACKAGE_OPTIONS "")

# tool options
list(APPEND PACKAGE_OPTIONS -D CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
list(APPEND PACKAGE_OPTIONS -D BUILD=MMG2D)
list(APPEND PACKAGE_OPTIONS -D BUILD_TESTING=OFF)
list(APPEND PACKAGE_OPTIONS -D TEST_LIBMMG2D=OFF)
list(APPEND PACKAGE_OPTIONS -D USE_SCOTCH=OFF)
list(APPEND PACKAGE_OPTIONS -D USE_ELAS=OFF)
list(APPEND PACKAGE_OPTIONS -D USE_VTK=OFF)

# build shared libs only because of LGPL
list(APPEND PACKAGE_OPTIONS -D BUILD_SHARED_LIBS=ON) 
list(APPEND PACKAGE_OPTIONS -D LIBMMG2D_STATIC=OFF)
list(APPEND PACKAGE_OPTIONS -D LIBMMG2D_SHARED=ON)

trapper_add_package(
    mmg
    https://github.com/kabukunz/mmg.git
    integration_v570

    VERBOSE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    PACKAGE_OPTIONS ${PACKAGE_OPTIONS}
    )

# ----------------------------------------------------------------------------------------------------

# set mmg dirs
set(MMG_SRC ${TRAPPER_SOURCE_DIR})
set(MMG_DIR ${TRAPPER_INSTALL_DIR})

message(STATUS "MMG_SRC: " ${MMG_SRC})
message(STATUS "MMG_DIR: " ${MMG_DIR})

# mmg needs source dir for cmake scripts
list(APPEND CMAKE_MODULE_PATH "${MMG_SRC}/cmake/tools")

# # set MMG helper dirs
set(MMG_INCDIR "${MMG_DIR}/include")
# set(MMG_LIBDIR "${MMG_DIR}/lib")
# set(MMG_BINDIR "${MMG_DIR}/bin")

set(MMG_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/mmg")

find_package(MMG CONFIG REQUIRED)

message(STATUS "MMG2D_INCLUDE_DIRS: " ${MMG_INCLUDE_DIRS})
message(STATUS "MMG2D_LIBRARIES: " ${MMG_LIBRARIES})

if(WIN32)
    add_library(MMG2D_DLL SHARED IMPORTED)
    set_property(TARGET MMG2D_DLL PROPERTY IMPORTED_LOCATION "${MMG_BINDIR}/mmg2d.dll")
endif()

#
# CLIENT
#

add_executable(mmg2dclient "${MMG_SRC}/libexamples/mmg2d/adaptation_example0/example0_a/main.c")

# include dirs
target_include_directories(mmg2dclient PUBLIC ${MMG2D_INCLUDE_DIRS})

# link library
target_link_libraries(mmg2dclient PUBLIC Mmg::libmmg2d_so)

# bin dir
set_target_properties(mmg2dclient PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

# Copy dll to bin dir
if(WIN32)
    add_custom_command(TARGET mmg2dclient POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:MMG2D_DLL> $<TARGET_FILE_DIR:mmg2dclient>
    )
endif()
