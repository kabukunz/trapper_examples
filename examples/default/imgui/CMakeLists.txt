cmake_minimum_required(VERSION 3.16.1)

project(imgui_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH ${TRAPPER_EXAMPLES_TRAPPER_DIR})

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# IMGUI: download needed prebuilt binaries, and just use it

trapper_add_package(
    glfw3
    https://github.com/glfw/glfw.git
    3.3-stable
    VERBOSE
    )

# https://stackoverflow.com/questions/34795816/hinting-findname-cmake-files-with-a-custom-directory

# add prebuilt config path to library search
list(APPEND CMAKE_PREFIX_PATH ${TRAPPER_INSTALL_DIR})

# glfw3
find_package(glfw3 3.3.6 REQUIRED)

trapper_add_package(
    imgui-cmake
    https://github.com/kabukunz/imgui-cmake.git
    afd4b0e515ad8413752d18ce43418d01b47e406f

    PACKAGE_OPTIONS "-DIMGUI_WITH_IMPL=${IMGUI_WITH_IMPL}"

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    
    VERBOSE
    )

# imgui
find_package(imgui 1.76 EXACT CONFIG REQUIRED)

# LINK : warning LNK4098: defaultlib 'MSVCRTD' conflicts with use of other libs; use /NODEFAULTLIB:library

# exe
set(IMGUI_EXAMPLES "${TRAPPER_SOURCE_DIR}/imgui/examples")

add_executable(${PROJECT_NAME} 
    "${IMGUI_EXAMPLES}/imgui_impl_glfw.cpp"
    "${IMGUI_EXAMPLES}/imgui_impl_opengl3.cpp"
    "${IMGUI_EXAMPLES}/libs/gl3w/GL/gl3w.c"
    "${IMGUI_EXAMPLES}/example_glfw_opengl3/main.cpp"
    )

set_target_properties(${PROJECT_NAME} 
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${TRAPPER_EXAMPLES_BINARY_DIR})

target_include_directories(${PROJECT_NAME} PUBLIC 
    "${IMGUI_EXAMPLES}"
    "${IMGUI_EXAMPLES}/libs/gl3w"
    )

# windows
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
