cmake_minimum_required(VERSION 3.14)

project(imgui_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/trapper")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# IMGUI: download needed prebuilt binaries, and just use it

# trapper_add_package(
#     glad
#     https://github.com/Dav1dde/glad.git
#     v0.1.34
#     VERBOSE
#     )

# NOTE: there's no package from this download. Resorting to use build dir to find libraries

# set(glad_DIR ${TRAPPER_INSTALL_DIR}/lib/cmake/glad CACHE STRING "glad_DIR")

# # find package
# find_package(glad CONFIG REQUIRED)

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



# add_executable(${PROJECT_NAME} ${TRAPPER_SOURCE_DIR}/example/c/simple.c)

# target_include_directories(${PROJECT_NAME} PUBLIC ${TRAPPER_INSTALL_DIR}/include)

# target_link_libraries(${PROJECT_NAME} PUBLIC glad::glad)

# set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})





trapper_add_package(
    glfw3
    https://github.com/glfw/glfw.git
    3.3-stable
    VERBOSE
    )


# https://stackoverflow.com/questions/34795816/hinting-findname-cmake-files-with-a-custom-directory
# adding package to search
list(APPEND CMAKE_PREFIX_PATH "${TRAPPER_INSTALL_DIR}")


## Find dependencies
find_package(glfw3 3.3.6 REQUIRED)
# find_package(glad REQUIRED)
# find_package(glm REQUIRED)
# find_package(freetype REQUIRED)
# find_package(imgui REQUIRED)

# stb does not have a CMake build, but is header-only 1
# find_path(STB_INCLUDE_DIRS "stb.h")

trapper_add_package(
    imgui-cmake
    https://github.com/kabukunz/imgui-cmake.git
    2b3cb7c02bc5ae20d90ae885adf66630d02bb80f
    PACKAGE_OPTIONS -DIMGUI_WITH_IMPL=${IMGUI_WITH_IMPL}
    
    VERBOSE
    )







## Create main executable
add_executable(main ImGuiBuilder/ImGuiBuilder/main.cpp)

target_include_directories(main 
  PRIVATE 
    "${CMAKE_CURRENT_LIST_DIR}/ImGuiBuilder/ImGuiBuilder"
)

target_compile_definitions(main PRIVATE _OPENGL2=1)

target_link_libraries(main PRIVATE
    glfw
)
