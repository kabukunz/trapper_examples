cmake_minimum_required(VERSION 3.14)

project(imgui_client LANGUAGES C CXX)

# list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH ../../../cmake)

include(Trapper)

# we need install dir for find package
# set(TRAPPER_INSTALL_DIR "${CMAKE_SOURCE_DIR}/prebuilt" CACHE PATH "")

# ----------------------------------------------------------------------------------------------------

# IMGUI: download needed prebuilt binaries, and just use it

trapper_add_package(
    TOOL glad
    LOCATION https://github.com/Dav1dde/glad.git
    HASHING v0.1.34
    VERBOSE
    )

# NOTE: there's no package from this download. Resorting to use build dir to find libraries

set(glad_DIR ${TRAPPER_INSTALL_DIR}/lib/cmake/glad CACHE STRING "glad_DIR")

# find package
find_package(glad CONFIG REQUIRED)

# GLAD_LIBRARIES
# GLAD_INCLUDE_DIRS

# # Create a library for the viewer code
# add_library(${TRAPPER_SOURCE_DIR}
#     glad
#     glad.c
#     )

# target_include_directories(glad PRIVATE "../include")    

# set_target_properties(glad PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

# if(glad_FOUND)
#     message(STATUS "MMG2D LIBRARY DIRS = ${MMG2D_LIBRARY_DIRS}")
# endif()

add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/example/c/simple.c)

target_include_directories(${PROJECT_NAME} PUBLIC ${TRAPPER_INSTALL_DIR}/include)

target_link_libraries(${PROJECT_NAME} PUBLIC glad::glad)

set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
