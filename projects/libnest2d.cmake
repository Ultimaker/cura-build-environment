#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

#libnest2d (dependency of pynest2d).
ExternalProject_Add(libnest2d
    GIT_REPOSITORY https://github.com/tamasmeszaros/libnest2d.git
    GIT_TAG da4782500da4eb8cb6e38e5e3f10164ec5a59778 #First tag with LGPL license.
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    DEPENDS BoostHeaders nlopt Clipper
)
