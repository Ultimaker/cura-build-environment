#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

#NLopt (dependency of libnest2d).
ExternalProject_Add(NLopt
    GIT_REPOSITORY https://github.com/stevengj/nlopt.git
    GIT_TAG v2.6.2
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
)
