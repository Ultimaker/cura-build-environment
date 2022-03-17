#Copyright (c) 2022 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            PYNEST2D_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for pynest2d")

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX})
endif()

ExternalProject_Add(pynest2d
    GIT_REPOSITORY https://github.com/Ultimaker/pynest2d.git
    GIT_TAG origin/${PYNEST2D_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
               -DBUILD_STATIC=OFF
               ${extra_cmake_args}
    BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} || echo "ignore error"
    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
)

SetProjectDependencies(TARGET pynest2d DEPENDS Python libnest2d)
