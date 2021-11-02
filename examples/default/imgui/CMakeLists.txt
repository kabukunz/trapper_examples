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

# find_package(OpenGL REQUIRED)

# find_package(glad REQUIRED)
# find_package(glm REQUIRED)
# find_package(freetype REQUIRED)
# find_package(imgui REQUIRED)

# stb does not have a CMake build, but is header-only 1
# find_path(STB_INCLUDE_DIRS "stb.h")

trapper_add_package(
    imgui-cmake
    https://github.com/kabukunz/imgui-cmake.git
    54d8443129b1dc68952707a1a14c0815ed737262

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    # PACKAGE_OPTIONS 
        # -DIMGUI_WITH_IMPL=${IMGUI_WITH_IMPL}
        # -DIMGUI_IMPL_GLFW3_OPENGL3=${IMGUI_IMPL_GLFW3_OPENGL3}
    
    VERBOSE
    )

list(APPEND CMAKE_PREFIX_PATH "${TRAPPER_INSTALL_DIR}")


# include(${TRAPPER_INSTALL_DIR}/lib/cmake/imgui.cmake)

# add_library(imgui STATIC IMPORTED)
# set_property(TARGET imgui PROPERTY IMPORTED_LOCATION "${TRAPPER_INSTALL_DIR}/lib/imgui.lib")

find_package(imgui 1.7.1 EXACT)


# CHECK: imgui has glfw inside?
# include(CMakeFindDependencyMacro)
# find_dependency(glfw3 3.3)

# LINK : warning LNK4098: defaultlib 'MSVCRTD' conflicts with use of other libs; use /NODEFAULTLIB:library

## Create main executable

# cl /nologo /Zi /MD /I .. /I ..\.. /I ..\libs\glfw\include /I ..\libs\gl3w *.cpp ..\imgui_impl_glfw.cpp ..\imgui_impl_opengl3.cpp ..\..\imgui*.cpp ..\libs\gl3w\GL\gl3w.c /FeDebug/example_glfw_opengl3.exe /FoDebug/ /link /LIBPATH:..\libs\glfw\lib-vc2010-32 glfw3.lib opengl32.lib gdi32.lib shell32.lib

set(IMGUI_EXAMPLES "${TRAPPER_SOURCE_DIR}/imgui/examples")

add_executable(${PROJECT_NAME} 
    "${IMGUI_EXAMPLES}/imgui_impl_glfw.cpp"
    "${IMGUI_EXAMPLES}/imgui_impl_opengl3.cpp"
    "${IMGUI_EXAMPLES}/libs/gl3w/GL/gl3w.c"
    "${IMGUI_EXAMPLES}/example_glfw_opengl3/main.cpp"
    )

target_include_directories(${PROJECT_NAME} PUBLIC 
    "${IMGUI_EXAMPLES}"
    # "${IMGUI_EXAMPLES}/libs/glfw/include"
    "${IMGUI_EXAMPLES}/libs/gl3w"
    )

# target_link_libraries(${PROJECT_NAME} PUBLIC
#     "${IMGUI_EXAMPLES}/libs/glfw/lib-vc2010-64/glfw3.lib"
#     imgui::imgui
#     opengl32
# )

target_link_libraries(${PROJECT_NAME} PUBLIC
    glfw
    imgui::imgui
    ${OPENGL_LIBRARIES}
)
