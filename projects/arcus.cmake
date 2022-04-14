# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            ARCUS_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag (e.q.: v4.13.0), branch (e.q.: origin/CURA-8640) or commit hash (e.q.: 961dabf) for Arcus")

ExternalProject_Add(Arcus
        GIT_REPOSITORY https://github.com/Ultimaker/libArcus.git
        GIT_TAG ${ARCUS_BRANCH_OR_TAG}
        CMAKE_GENERATOR ${CMAKE_GENERATOR}
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
                   -DSIP_BUILD_EXECUTABLE=${CMAKE_INSTALL_PREFIX}/${exe_path}/sip-build
                   -DPYTHONPATH=${PYTHONPATH}
                   -DPython_SITELIB_LOCAL=${Python_SITELIB_LOCAL}
                   -DPython_ROOT=${CMAKE_INSTALL_PREFIX}
                   -DPython_EXECUTABLE=${Python_VENV_EXECUTABLE})
add_dependencies(Arcus install-python-requirements)
