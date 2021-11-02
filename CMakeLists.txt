cmake_minimum_required(VERSION 3.16.1)

project(trapper_examples)

set(TRAPPER_EXAMPLES_TRAPPER_DIR "${CMAKE_SOURCE_DIR}/trapper")
set(TRAPPER_EXAMPLES_BINARY_DIR "${CMAKE_SOURCE_DIR}/bin")

add_subdirectory(examples)
