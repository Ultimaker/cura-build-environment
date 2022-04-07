#Copyright (c) 2022 Ultimaker B.V.
#cura-build is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            CHARON_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for libCharon")

ExternalProject_Add(Charon
    GIT_REPOSITORY https://github.com/Ultimaker/libCharon
    GIT_TAG ${CHARON_BRANCH_OR_TAG}
    CMAKE_GENERATOR ${CMAKE_GENERATOR}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
               -DPython_ROOT=${Python_ROOT}
               -DPython_SITELIB_LOCAL=${Python_SITELIB_LOCAL})
add_dependencies(Charon install-python-requirements)
