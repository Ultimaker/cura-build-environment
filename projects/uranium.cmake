# Copyright (c) 2022 Ultimaker B.V.
# cura-build is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            URANIUM_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for Uranium")

GetFromEnvironmentOrCache(
        NAME
            CURA_NO_INSTALL_PLUGINS
        DESCRIPTION
            "A list of plugins to exclude from installation, should be separated by ','.")

ExternalProject_Add(Uranium
    GIT_REPOSITORY https://github.com/ultimaker/Uranium
    GIT_TAG ${URANIUM_BRANCH_OR_TAG}
    CMAKE_GENERATOR ${CMAKE_GENERATOR}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
               -DPython_ROOT=${Python_ROOT}
               -DPython_SITELIB_LOCAL=${Python_SITELIB_LOCAL}
               -DUM_NO_INSTALL_PLUGINS=${CURA_NO_INSTALL_PLUGINS})
add_dependencies(Uranium install-python-requirements Arcus Savitar)
