
cmake_minimum_required(VERSION 3.14)

project(eigen LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

file(DOWNLOAD https://raw.githubusercontent.com/kabukunz/trapper/main/Trapper.cmake "${CMAKE_MODULE_PATH}/Trapper.cmake")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

# eigen: header-only download, build into static lib

trapper_add_package(
    eigen
    https://gitlab.com/libeigen/eigen.git
    3.4.0
    
    HEADER_ONLY
    VERBOSE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    )

# ----------------------------------------------------------------------------------------------------

# set eigen dir
set(Eigen_DIR ${TRAPPER_SOURCE_DIR} CACHE STRING "Eigen_DIR")

# library
add_library(${PROJECT_NAME} STATIC lib.cpp)

# set eigen include dir
target_include_directories(${PROJECT_NAME} PUBLIC ${Eigen_DIR})

# exe
add_executable(${PROJECT_NAME}_exe main.cpp)

# link eigen lib
target_link_libraries(${PROJECT_NAME}_exe PUBLIC ${PROJECT_NAME})

# props
set_target_properties(${PROJECT_NAME}_exe PROPERTIES 
    OUTPUT_NAME ${PROJECT_NAME}
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

