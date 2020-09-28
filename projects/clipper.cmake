#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

#Clipper (dependency of libnest2d).
ExternalProject_Add(Clipper
    URL https://sourceforge.net/projects/polyclipping/files/clipper_ver6.4.2.zip
    URL_HASH SHA1=b05c1f454c22576f867fc633b11337d053e9ea33
    SOURCE_SUBDIR cpp
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
)
