# Copyright 2022 Ultimaker

# Setting the MACOSX_DEPLOYMENT_TARGET needs to be done before the first project() call. Setting this value should also
# take care of the CMAKE_OSX_SYSROOT. The variable is ignored on non-Apple systems.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(GetFromEnvironmentOrCache)
GetFromEnvironmentOrCache(
        NAME
            CMAKE_OSX_DEPLOYMENT_TARGET
        DESCRIPTION
            "Specify the minimum version of the target platform (e.g. macOS or iOS)")

project(cura-build-environment)
cmake_minimum_required(VERSION 3.18)

include(cmake/conan.cmake)

include(ExternalProject)
include(GNUInstallDirs)
include(ProcessorCount)

ProcessorCount(N_PROC)
if(N_PROC EQUAL 0)
    set(N_PROC 1)
endif()

add_custom_target(projects)

include(projects/python.cmake)
include(projects/libnest2d.cmake)
include(projects/pynest2d.cmake)
#include(projects/arcus.cmake)
#include(projects/savitar.cmake)