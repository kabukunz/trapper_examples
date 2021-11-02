cmake_minimum_required(VERSION 3.14)

project(embree_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_DIR})

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# EMBREE: download and install a prebuilt binary

# download binaries
if(WIN32)
    SET(EMBREE_PREBUILT_VERSION "https://github.com/embree/embree/releases/download/v3.5.2/embree-3.5.2.x64.vc14.windows.zip")
elseif(APPLE)
    SET(EMBREE_PREBUILT_VERSION "https://github.com/embree/embree/releases/download/v3.5.2/embree-3.5.2.x86_64.macosx.tar.gz")
else()
    message(FATAL "Embree prebuilt platform not found")
endif()

# get prebuilt version
trapper_add_package(embree ${EMBREE_PREBUILT_VERSION} "" INSTALL_PREBUILT)

# ----------------------------------------------------------------------------------------------------

# set vars for find_package
set(embree_DIR ${TRAPPER_INSTALL_DIR})

# find Embree
find_package(embree 3.5.2 CONFIG REQUIRED)
