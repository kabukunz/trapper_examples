# https://stackoverflow.com/questions/47139378/transitively-copy-dlls-in-a-cmake-project
# https://github.com/ComicSansMS/GhulbusBase/blob/master/cmake/gbBaseMacros.cmake.in

function(addRuntimeDependencies target dependency)
    if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
        get_property(imported_configs TARGET ${dependency} PROPERTY IMPORTED_CONFIGURATIONS)
        set(dlls "")
        foreach(cfg ${imported_configs})
            get_property(dll TARGET ${dependency} PROPERTY IMPORTED_LOCATION_${cfg})
            set(dlls ${dlls} $<$<CONFIG:${cfg}>:${dll}>)
        endforeach()
        message("Copying dependencies: ${dll}")
        add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${dlls}
            $<TARGET_FILE_DIR:${target}>)
    endif()
endfunction()
