
if(TRAPPER_BUILD_MMG_EXAMPLE)
    add_subdirectory(mmg)
endif()

if(TRAPPER_BUILD_EMBREE_EXAMPLE)
    add_subdirectory(embree)
endif()

if(TRAPPER_BUILD_DLIB_EXAMPLE)
    add_subdirectory(dlib)
endif()    

if(TRAPPER_BUILD_POLYSCOPE_EXAMPLE)
    add_subdirectory(polyscope)
endif()

if(TRAPPER_BUILD_IMGUI_EXAMPLE)
    add_subdirectory(imgui)
endif()

if(TRAPPER_BUILD_NANOFLANN_EXAMPLE)
    add_subdirectory(nanoflann)
endif()

if(TRAPPER_BUILD_DIRECTIONAL_EXAMPLE)
    add_subdirectory(directional)
endif()

if(TRAPPER_BUILD_LIBZIPPP_EXAMPLE)
    add_subdirectory(libzippp)
endif()
