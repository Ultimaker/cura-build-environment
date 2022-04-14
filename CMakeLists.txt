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
include(cmake/os.cmake)

include(ExternalProject)
include(GNUInstallDirs)

# Create the version-related variables
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_MAJOR
        DEFAULT
            "5"
        DESCRIPTION
            "Cura Major Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_MINOR
        DEFAULT
            "0"
        DESCRIPTION
            "Cura Minor Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_PATCH
        DEFAULT
            "0"
        DESCRIPTION
            "Cura Patch Version")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_PRE_RELEASE_TAG
        DESCRIPTION
            "Cura pre release tag Version Information a, b or rc")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION_BUILD
        DESCRIPTION
            "Cura Version buildmetadata ignored when determining version precedence. Only used to identify a build.")
set(CURA_VERSION_EXTRA )
if(NOT ${CURA_VERSION_PRE_RELEASE_TAG} STREQUAL "")
    set(CURA_VERSION_EXTRA "-${CURA_VERSION_PRE_RELEASE_TAG}+${CURA_VERSION_BUILD}")
endif()
set(_default_cura_version "${CURA_VERSION_MAJOR}.${CURA_VERSION_MINOR}.${CURA_VERSION_PATCH}${CURA_VERSION_EXTRA}")
GetFromEnvironmentOrCache(
        NAME
            CURA_VERSION
        DEFAULT
            ${_default_cura_version}
        DESCRIPTION
            "Cura Extra Version Information"
        REQUIRED)

include(projects/python.cmake)
include(projects/charon.cmake)
include(projects/savitar.cmake)
include(projects/arcus.cmake)
include(projects/uranium.cmake)
include(projects/libnest2d.cmake)
include(projects/pynest2d.cmake)
include(projects/curaengine.cmake)
include(projects/cura.cmake)
include(projects/fdm_materials.cmake)
include(projects/cura-binary-data.cmake)

# Collect the artifacts with pyinstaller
include(cmake/pyinstaller.cmake)

if(APPLE)
    include(cmake/create-dmg.cmake)
    include(cmake/sign-dmg.cmake)
    include(cmake/notarize-dmg.cmake)
endif()

if(LINUX)
    include(cmake/create-appimage.cmake)
    include(cmake/sign-appimage.cmake)
endif()

if(WIN32)
    include(cmake/nsis.cmake)
endif()

include(cmake/dev.cmake)