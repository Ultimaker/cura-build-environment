# Copyright (c) 2022 Ultimaker B.V.
# cura-build is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            CURAENGINE_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for CuraEngine")
GetFromEnvironmentOrCache(
        NAME
            CURA_ENGINE_VERSION
        DEFAULT
            ${CURA_VERSION}
        DESCRIPTION
            "The version of CuraEngine")

ExternalProject_Add(CuraEngine
        GIT_REPOSITORY https://github.com/ultimaker/CuraEngine
        GIT_TAG ${CURAENGINE_BRANCH_OR_TAG}
        GIT_SHALLOW 1
        STEP_TARGETS update
        CMAKE_GENERATOR ${CMAKE_GENERATOR}
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
                   -DCURA_ENGINE_VERSION=${CURA_ENGINE_VERSION})
add_dependencies(CuraEngine Arcus)