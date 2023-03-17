################################################################################
include(DownloadProject)

# # With CMake 3.8 and above, we can hide warnings about git being in a
# # detached head by passing an extra GIT_CONFIG option.
# set(LIBIGL_EXTRA_OPTIONS TLS_VERIFY OFF)
# if(NOT (${CMAKE_VERSION} VERSION_LESS "3.8.0"))
# 	list(APPEND LIBIGL_EXTRA_OPTIONS GIT_CONFIG advice.detachedHead=false)
# endif()

# # On CMake 3.6.3 and above, there is an option to use shallow clones of git repositories.
# # The shallow clone option only works with real tags, not SHA1, so we use a separate option.
# set(LIBIGL_BRANCH_OPTIONS)
# if(NOT (${CMAKE_VERSION} VERSION_LESS "3.6.3"))
# 	# Disabled for now until we can make sure that it has no adverse effects
# 	# (Downside is that the eigen mirror is huge again)
# 	# list(APPEND LIBIGL_BRANCH_OPTIONS GIT_SHALLOW 1)
# endif()

# option(LIBIGL_SKIP_DOWNLOAD "Skip downloading external libraries" OFF)

# Shortcut functions
function(trexam_download_project_aux name source)
	if(NOT TREXAM_SKIP_DOWNLOAD)
		download_project(
			PROJ         ${name}
			SOURCE_DIR   "${source}"
			DOWNLOAD_DIR "${TREXAM_EXTERNAL}/.cache/${name}"
			QUIET
			${TREXAM_EXTRA_OPTIONS}
			${ARGN}
		)
	endif()
endfunction()

function(trexam_download_project name)
	trexam_download_project_aux(${name} "${TREXAM_EXTERNAL}/${name}" ${ARGN})
endfunction()

################################################################################

# trapper
function(trexam_download_trapper)
    trexam_download_project(trapper
		GIT_REPOSITORY https://github.com/kabukunz/trapper.git
		GIT_TAG        v2.0
		)
endfunction()

################################################################################
