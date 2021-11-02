cmake_minimum_required(VERSION 3.14)

project(embree_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_DIR})

# ----------------------------------------------------------------------------------------------------

# EMBREE: download a prebuilt binary, and just use it

# # tool name (required)
# set(TOOL_NAME embree)

# # tool location (required) 
# set(TOOL_LOCATION "https://github.com/embree/embree/releases/download/v3.5.2/embree-3.5.2.x86_64.macosx.tar.gz")

# # tool platform
# set(TOOL_PLATFORM OFF)

# # tool version
# # set(TOOL_VERSION "3.5.2")
# set(TOOL_VERSION OFF)

# # tool hash, if any
# set(TOOL_HASHING OFF)

# # set this if downloads need to be in a specific directory
# set(TOOL_DOWNLOAD_DIR OFF)

# # set this if tool sources need to be in a specific directory
# set(TOOL_SOURCE_DIR OFF)

# # set this if tool binaries need to be in a specific directory
# set(TOOL_BUILD_DIR OFF)

# # set this if tool need to be installed in a specific directory (different from cmake default install prefix)
# set(TOOL_INSTALL_DIR ${TOOLS_INSTALL_DIR})

# # set this if tool is already built
# set(TOOL_ISPREBUILT ON)

# # set this if install has to be *nix-like
# set(TOOL_INSTALL_NOFORMAT ON)

# # reset options
# set(TOOL_OPTIONS "")

# # set prebuild project option
# list(APPEND TOOL_OPTIONS -D PREBUILD_EXTERNAL_PROJECT=ON)

# no other options, as it's prebuilt

# prebuild (this is built at once; execution stops until finished)

trapper_add_package(
    TOOL embree
    LOCATION "https://github.com/embree/embree/releases/download/v3.5.2/embree-3.5.2.x86_64.macosx.tar.gz"    
    INSTALL_PREBUILT
    INSTALL_NOFORMAT
    VERBOSE
    )

# set vars for find_package
set(embree_DIR ${TRAPPER_INSTALL_DIR})

# find Embree
find_package(embree 3.5.2 CONFIG REQUIRED)
