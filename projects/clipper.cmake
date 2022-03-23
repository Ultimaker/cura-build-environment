#Copyright (c) 2022 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

if(NOT TARGET Clipper)
    ExternalProject_Add(Clipper
        GIT_REPOSITORY https://github.com/skyrpex/clipper
        GIT_TAG 6.4.2
        PATCH_COMMAND git apply ${CMAKE_SOURCE_DIR}/projects/0002-install-location-runtime-libs.patch
        SOURCE_SUBDIR cpp
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_CXX_FLAGS=-fPIC
                   -DBUILD_SHARED_LIBS=OFF
    )
endif()
