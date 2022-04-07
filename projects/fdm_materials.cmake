# Copyright (c) 2022 Ultimaker B.V.
# cura-build is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            FDMMATERIALS_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for fdm_materials")

ExternalProject_Add(fdm_materials
        GIT_REPOSITORY https://github.com/ultimaker/fdm_materials
        GIT_TAG ${FDMMATERIALS_BRANCH_OR_TAG}
        GIT_SHALLOW 1
        STEP_TARGETS update
        CMAKE_GENERATOR ${CMAKE_GENERATOR}
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE})
add_dependencies(fdm_materials Cura)
