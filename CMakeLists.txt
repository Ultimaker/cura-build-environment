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
cmake_minimum_required(VERSION 3.20)

include(cmake/conan.cmake)

include(ExternalProject)
include(GNUInstallDirs)
include(ProcessorCount)

ProcessorCount(N_PROC)
if(N_PROC EQUAL 0)
    set(N_PROC 1)
endif()

# Create the version-related variables
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_MAJOR
        DEFAULT
            5
        DESCRIPTION
            "Cura Major Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_MINOR
        DEFAULT
            0
        DESCRIPTION
            "Cura Minor Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_PATCH
        DEFAULT
            0
        DESCRIPTION
            "Cura Patch Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_EXTRA
        DESCRIPTION
            "Cura Extra Version Information")
if(NOT ${CURA_VERSION_EXTRA} STREQUAL "")
    set(CURA_VERSION_EXTRA "-${CURA_VERSION_EXTRA}")
endif()
set(_default_cura_version "${CURA_VERSION_MAJOR}.${CURA_VERSION_MINOR}.${CURA_VERSION_PATCH}${CURA_VERSION_EXTRA}")
if(${_default_cura_version} VERSION_GREATER 0.0.0)
    set(CURA_VERSION ${_default_cura_version})
endif()
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION
        DESCRIPTION
            "Cura Extra Version Information"
        REQUIRED)

add_custom_target(projects)

include(projects/python.cmake)
include(projects/uranium.cmake)
include(projects/charon.cmake)
include(projects/libnest2d.cmake)
include(projects/pynest2d.cmake)
include(projects/arcus.cmake)
include(projects/savitar.cmake)
include(projects/curaengine.cmake)
include(projects/fdm_materials.cmake)
include(projects/cura-binary-data.cmake)
include(projects/cura.cmake)

# Collect the artifacts with pyinstaller
include(cmake/pyinstaller.cmake)

if(APPLE)
    include(cmake/macos-create-dmg.cmake)
    include(cmake/macos-sign-dmg.cmake)
    include(cmake/macos-notarize-dmg.cmake)
endif()