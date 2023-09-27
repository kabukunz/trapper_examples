cmake_minimum_required(VERSION 3.16)

project(imgui_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# MMG: download, build, and use installed tool

# reset options
set(PACKAGE_OPTIONS "")

    # cmake -H. -B $MMG_BUILD -G Ninja \
    # -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    # -DCMAKE_BUILD_TYPE=Release \
    # \
    # -DBUILD=MMG2D \
    # -DBUILD_TESTING=OFF \
    # -DTEST_LIBMMG2D=OFF \
    # -DBUILD_SHARED_LIBS=ON \
    # -DLIBMMG2D_STATIC=OFF \
    # -DLIBMMG2D_SHARED=ON \
    # -DUSE_SCOTCH=OFF \
    # -DUSE_ELAS=OFF \
    # -DUSE_VTK=OFF \
    # -DCMAKE_INSTALL_PREFIX:PATH=$MMG_INSTALL

# tool options
list(APPEND PACKAGE_OPTIONS -D CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
list(APPEND PACKAGE_OPTIONS -D BUILD=MMG2D)
list(APPEND PACKAGE_OPTIONS -D BUILD_TESTING=OFF)
list(APPEND PACKAGE_OPTIONS -D TEST_LIBMMG2D=OFF)
list(APPEND PACKAGE_OPTIONS -D BUILD_SHARED_LIBS=ON)
list(APPEND PACKAGE_OPTIONS -D LIBMMG2D_STATIC=OFF)
list(APPEND PACKAGE_OPTIONS -D LIBMMG2D_SHARED=ON)
list(APPEND PACKAGE_OPTIONS -D USE_SCOTCH=OFF)
list(APPEND PACKAGE_OPTIONS -D USE_ELAS=OFF)
list(APPEND PACKAGE_OPTIONS -D USE_VTK=OFF)

trapper_add_package(
    mmg
    https://github.com/kabukunz/mmg.git
    integration_v570

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"

    PACKAGE_OPTIONS ${PACKAGE_OPTIONS}
    
    VERBOSE
    )

# mmg
set(MMG_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/mmg")
find_package(MMG CONFIG REQUIRED)
    