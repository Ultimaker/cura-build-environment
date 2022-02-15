#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

set(pylib_cmake_command ${CMAKE_COMMAND})

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX})
elseif(BUILD_OS_OSX)
    if(CMAKE_OSX_DEPLOYMENT_TARGET)
        list(APPEND extra_cmake_args
            -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
        )
    endif()
    if(CMAKE_OSX_SYSROOT)
        list(APPEND extra_cmake_args
            -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
        )
    endif()
endif()

ExternalProject_Add(pynest2d
    GIT_REPOSITORY https://github.com/Ultimaker/pynest2d.git
    GIT_TAG origin/${CURA_PYNEST2D_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    CMAKE_COMMAND ${pylib_cmake_command}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
               -DBUILD_STATIC=OFF
			   -DPY_DEPEND_BIN_INSTALL_DIR=${CMAKE_INSTALL_PREFIX}/Lib/site-packages
			   -DPYNEST2D_EXTRA_INCLUDES=${CMAKE_INSTALL_PREFIX}/include
			   -DPYNEST2D_EXTRA_LIBS=${CMAKE_INSTALL_PREFIX}/bin
               ${extra_cmake_args}
	BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} || echo "ignore error"
	COMMAND ${CMAKE_MAKE_PROGRAM} || echo "ignore error"
	INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install || echo "ignore error"
	COMMAND sip-install --target-dir ${CMAKE_INSTALL_PREFIX}/lib/site-packages
)
# TODO: Ignoring the first error (in the 1st) build command is hacky, but functions,
#       since any errors that are of a more permanent nature would be picked up by the 2nd identical one.
#         ... ignoring the ones _after_ that is just bad.
#       But it will make the _actual_ file we need, so do it like that for now.

SetProjectDependencies(TARGET pynest2d DEPENDS Python libnest2d)
