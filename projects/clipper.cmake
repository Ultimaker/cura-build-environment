#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

#Clipper (dependency of libnest2d).

#CMake 3.6 (our minimum requirement) doesn't support SOURCE_SUBDIR yet. Instead we copy the source from the cpp subfolder to the main folder.
if(NOT TARGET Clipper)
    ExternalProject_Add(Clipper
        GIT_REPOSITORY https://github.com/skyrpex/clipper
        GIT_TAG 6.4.2
        PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_BINARY_DIR}/Clipper-prefix/src/Clipper/cpp" "${CMAKE_CURRENT_BINARY_DIR}/Clipper-prefix/src/Clipper" && ${CMAKE_COMMAND} -E copy "${CMAKE_SOURCE_DIR}/projects/clipper_cmakelists_patch.txt" "${CMAKE_CURRENT_BINARY_DIR}/Clipper-prefix/src/Clipper/CMakeLists.txt" && ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/Clipper-prefix/src/Clipper/clipper.hpp" "${CMAKE_INSTALL_PREFIX}/include/"
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_CXX_FLAGS=-fPIC
                   -DBUILD_SHARED_LIBS=OFF
    )
endif()
