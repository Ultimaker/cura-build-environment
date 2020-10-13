#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

include(${CMAKE_CURRENT_SOURCE_DIR}/projects/boost_headers.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/projects/nlopt.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/projects/clipper.cmake)

#libnest2d (dependency of pynest2d).
ExternalProject_Add(libnest2d
    GIT_REPOSITORY https://github.com/Ultimaker/libnest2d.git
    GIT_TAG master
    GIT_SHALLOW 1
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/projects/libnest2d_find_clipper.cmake" "${CMAKE_CURRENT_BINARY_DIR}/libnest2d-prefix/src/libnest2d/cmake_modules/FindClipper.cmake"
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    DEPENDS BoostHeaders nlopt Clipper
)
