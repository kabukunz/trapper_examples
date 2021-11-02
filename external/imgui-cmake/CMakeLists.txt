#
# ImGui Library
#

# CHECK: too high?
cmake_minimum_required(VERSION 3.6.0)

include(CMakeOptions.cmake)
include(CMakeImplFiles.cmake)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

##################################################################################################################
# Setup (change imgui version according to your needs)
##################################################################################################################
set(version 1.7.1)

project(imgui
        VERSION ${version}
        LANGUAGES CXX
        DESCRIPTION "ImGui library."
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/$<CONFIG>)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/$<CONFIG>)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/$<CONFIG>)
set(CMAKE_PDB_OUTPUT_DIRECTORY     ${CMAKE_BINARY_DIR}/bin/$<CONFIG>)

set(CMAKE_VERBOSE_MAKEFILE TRUE)

if (WIN32)
  if (IMGUI_STATIC_LIBRARY)
    message(STATUS "[INFO] Building library as --> Static Library")
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
  else()
    message(STATUS "[INFO] Building library as --> DLL")
    set(BUILD_SHARED_LIBS ON)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
  endif()
endif()

set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/imgui)
set(EXAMPLES_DIR ${SOURCE_DIR}/examples)
set(LIBS_DIR ${EXAMPLES_DIR}/libs)
set(FONTS_DIR ${SOURCE_DIR}/misc/fonts)


##################################################################################################################
# Project Files
##################################################################################################################
set(HEADERS_CXX_FILES 
    ${SOURCE_DIR}/imgui.h
    ${SOURCE_DIR}/imconfig.h
    ${SOURCE_DIR}/imgui_internal.h
    ${SOURCE_DIR}/imstb_rectpack.h
    ${SOURCE_DIR}/imstb_textedit.h
    ${SOURCE_DIR}/imstb_truetype.h
)

set(SOURCES_CXX_FILES 
    ${SOURCE_DIR}/imgui.cpp
    ${SOURCE_DIR}/imgui_draw.cpp
    ${SOURCE_DIR}/imgui_widgets.cpp
    ${SOURCE_DIR}/imgui_demo.cpp
)

file(GLOB FONTS_FILES ${FONTS_DIR}/*.ttf)

set(HEADERS_CXX_IMPL_FILES)
set(SOURCES_CXX_IMPL_FILES)
if (IMGUI_WITH_IMPL)
  Init_Impl_Files(HEADERS_CXX_IMPL_FILES SOURCES_CXX_IMPL_FILES)
endif()

set(HEADERS_LIB_FILES
    ${LIBS_DIR}/gl3w/GL/gl3w.h
    ${LIBS_DIR}/gl3w/GL/glcorearb.h
    ${LIBS_DIR}/glfw/include/GLFW/glfw3.h
    ${LIBS_DIR}/glfw/include/GLFW/glfw3native.h
    )

set(SOURCES_LIB_FILES
    ${LIBS_DIR}/gl3w/GL/gl3w.c
)

unset(HEADERS_LIB_FILES)
unset(SOURCES_LIB_FILES)

##################################################################################################################
# IDE Representation
##################################################################################################################
# Groups CMake pre-defined projects:
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

source_group("Header Files" FILES
    ${HEADERS_CXX_FILES}
)
source_group("Header Files\\Impl" FILES
    ${HEADERS_CXX_IMPL_FILES}
)
source_group("Source Files" FILES
    ${SOURCES_CXX_FILES}
)
source_group("Source Files\\Impl" FILES
    ${SOURCES_CXX_IMPL_FILES}
)
source_group("Resource Files" FILES
    ${FONTS_FILES}
)


##################################################################################################################
# Target
##################################################################################################################
add_library(${PROJECT_NAME} 
    ${HEADERS_CXX_FILES}
    ${SOURCES_CXX_FILES}
    ${HEADERS_CXX_IMPL_FILES}
    ${SOURCES_CXX_IMPL_FILES}
    ${HEADERS_LIB_FILES}
    ${SOURCES_LIB_FILES}
    ${FONTS_FILES}
)

list(APPEND IMGUI_INCLUDE_DIRS
    ${SOURCE_DIR}
    ${SOURCE_DIR}/examples
    ${SOURCE_DIR}/examples/libs/gl3w
    ${SOURCE_DIR}/examples/libs/glfw/include
    )

target_include_directories(${PROJECT_NAME} PUBLIC
    "$<BUILD_INTERFACE:${IMGUI_INCLUDE_DIRS}>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
    )

if(IMGUI_IMPL_DX12 AND NOT IMGUI_STATIC_LIBRARY)
    target_link_libraries(${PROJECT_NAME} PUBLIC d3d12)
endif()

unset(IMGUI_IMPL_GLFW3_OPENGL3)
if(IMGUI_IMPL_GLFW3_OPENGL3 AND IMGUI_STATIC_LIBRARY)
    target_link_libraries(${PROJECT_NAME} PUBLIC "imgui/examples/libs/glfw/lib-vc2010-64/glfw3.lib")
endif()


##################################################################################################################
# Target Install
##################################################################################################################

# sources
install(
    TARGETS ${PROJECT_NAME}
    EXPORT "${PROJECT_NAME}Targets"
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )

install(
    FILES ${HEADERS_CXX_FILES} ${HEADERS_CXX_IMPL_FILES} ${HEADERS_LIB_FILES}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )

install(
    FILES ${FONTS_FILES}
    DESTINATION "${CMAKE_INSTALL_PREFIX}/misc/fonts"
    )

# library
install(EXPORT ${PROJECT_NAME}Targets
    FILE "${PROJECT_NAME}Targets.cmake"
    NAMESPACE "${PROJECT_NAME}::"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
    )

# package
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
    )

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
    )

# version

# set(version 1.7.1)
set_property(TARGET ${PROJECT_NAME} PROPERTY VERSION ${version})
set_property(TARGET ${PROJECT_NAME} PROPERTY SOVERSION 1)
set_property(TARGET ${PROJECT_NAME} PROPERTY "INTERFACE_${PROJECT_NAME}_MAJOR_VERSION" 1)
set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY COMPATIBLE_INTERFACE_STRING "${PROJECT_NAME}_MAJOR_VERSION")

# generate the version file for the config file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION "${version}"
  COMPATIBILITY AnyNewerVersion
)

# export in the build tree
export(EXPORT "${PROJECT_NAME}Targets"
       FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME}Targets.cmake"
       NAMESPACE "${PROJECT_NAME}::"
)

# 
# 
# 

# Install PDB files for VS builds to enable debugging:
if (MSVC)
  if (NOT IMGUI_STATIC_LIBRARY)
    install(
        FILES $<TARGET_PDB_FILE:${PROJECT_NAME}> 
        DESTINATION lib
        CONFIGURATIONS Debug OR RelWithDebInfo
        COMPONENT libraries
        OPTIONAL
    )
  else()
    install(
        FILES 
          $<$<CONFIG:Debug>:${CMAKE_BINARY_DIR}/bin/$<CONFIG>/${PROJECT_NAME}.pdb>
          $<$<CONFIG:RelWithDebInfo>:${CMAKE_BINARY_DIR}/${PROJECT_NAME}.dir/$<CONFIG>/${PROJECT_NAME}.pdb>
        DESTINATION lib
        CONFIGURATIONS Debug OR RelWithDebInfo
        COMPONENT libraries
        OPTIONAL
    )
  endif()
endif()

