cmake_minimum_required(VERSION 3.16)

project(polyscope_client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(TREXAM_EXTERNAL "${CMAKE_SOURCE_DIR}/cmake")
include(TrexamDownloadExternal)
trexam_download_trapper()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/trapper")

include(Trapper)

# ----------------------------------------------------------------------------------------------------

trapper_add_package(
    polyscope
    https://github.com/nmwsharp/polyscope.git
    v1.3.0

    VERBOSE

    PACKAGE_OPTIONS
        -DPOLYSCOPE_BACKEND_OPENGL_MOCK=OFF
    
    # SOURCE_DIR "${CMAKE_SOURCE_DIR}/external"
    )

# ----------------------------------------------------------------------------------------------------

# # set mmg dirs
# set(MMG_SRC ${TRAPPER_SOURCE_DIR})
# set(MMG_DIR ${TRAPPER_INSTALL_DIR})

# message(STATUS "MMG_SRC: " ${MMG_SRC})
# message(STATUS "MMG_DIR: " ${MMG_DIR})

# # mmg needs source dir for cmake scripts
# list(APPEND CMAKE_MODULE_PATH "${MMG_SRC}/cmake/tools")

# # # set MMG helper dirs
# set(MMG_INCDIR "${MMG_DIR}/include")
# set(MMG_LIBDIR "${MMG_DIR}/lib")
# set(MMG_BINDIR "${MMG_DIR}/bin")

# set(MMG_DIR "${TRAPPER_INSTALL_DIR}/lib/cmake/mmg")
# find_package(MMG CONFIG REQUIRED)

# message(STATUS "MMG_INCLUDE_DIRS: " ${MMG_INCLUDE_DIRS})
# message(STATUS "MMG_LIBRARIES: " ${MMG_LIBRARIES})

# if(WIN32)
#     add_library(MMG2D_DLL SHARED IMPORTED)
#     set_property(TARGET MMG2D_DLL PROPERTY IMPORTED_LOCATION "${MMG_BINDIR}/mmg2d.dll")
# endif()

# #
# # CLIENT
# #

# add_executable(mmg2dclient "${MMG_SRC}/libexamples/mmg2d/adaptation_example0/example0_a/main.c")

# # include dirs
# target_include_directories(mmg2dclient PUBLIC ${MMG_INCLUDE_DIRS})

# # link library
# target_link_libraries(mmg2dclient PUBLIC Mmg::libmmg2d_so)

# # bin dir
# set_target_properties(mmg2dclient PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

# # Copy dll to bin dir
# if(WIN32)
#     add_custom_command(TARGET mmg2dclient POST_BUILD
#         COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:MMG2D_DLL> $<TARGET_FILE_DIR:mmg2dclient>
#     )
# endif()


