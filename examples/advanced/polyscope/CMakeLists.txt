cmake_minimum_required(VERSION 3.14)

project(polyscope_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# ----------------------------------------------------------------------------------------------------

# polyscope: header lib, download and build, no installation

# # tool name (required)
# set(TOOL_NAME polyscope)

# # tool location (required) 
# set(TOOL_LOCATION "https://github.com/nmwsharp/polyscope.git")

# # tool platform
# set(TOOL_PLATFORM OFF)

# # tool version
# set(TOOL_VERSION OFF)

# # tool hash, if any
# set(TOOL_HASHING "v1.2.0")

# # set this if downloads need to be in a specific directory
# set(TOOL_DOWNLOAD_DIR OFF)

# # set this if tool sources need to be in a specific directory
# set(TOOL_SOURCE_DIR ${TOOLS_SOURCE_DIR})

# # set this if tool binaries need to be in a specific directory
# set(TOOL_BUILD_DIR ${TOOLS_BUILD_DIR})

# # set this if tool need to be installed in a specific directory (different from cmake default install prefix)
# set(TOOL_INSTALL_DIR OFF)

# # set this if tool is already built
# set(TOOL_ISPREBUILT OFF)

# # set this if install has to be *nix-like
# set(TOOL_INSTALL_NOFORMAT ON)

# # reset options
# set(TOOL_OPTIONS "")

# # tool options
# list(APPEND TOOL_OPTIONS -D POLYSCOPE_BACKEND_OPENGL_MOCK=${POLYSCOPE_BACKEND_OPENGL_MOCK})

# prebuild (this is built at once; execution stops until finished)
# prebuild_external_project(
#     ${TOOL_NAME}
#     ${TOOL_LOCATION}
#     ${TOOL_HASHING}
#     ${TOOL_PLATFORM}
#     ${TOOL_VERSION}
#     ${TOOL_DOWNLOAD_DIR}
#     ${TOOL_SOURCE_DIR}
#     ${TOOL_BUILD_DIR}
#     ${TOOL_INSTALL_DIR}
#     ${TOOL_ISPREBUILT}
#     ${TOOL_INSTALL_NOFORMAT}
#     ${TOOL_OPTIONS}
#     )

trapper_add_package(
    TOOL polyscope
    LOCATION "https://github.com/nmwsharp/polyscope.git"
    HASHING "v1.2.0"
    SKIP_INSTALL
    VERBOSE
    )
    
# doesn't work
# add_subdirectory(src/polyscope)


