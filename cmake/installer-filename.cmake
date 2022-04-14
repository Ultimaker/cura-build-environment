# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            POSTFIX_OS_INSTALLER_FILENAME_WINDOWS
        DEFAULT
            win64
        DESCRIPTION
            "postfix for the installer file name when a Windows build is made (default win64): Ultimaker-Cura-5.0.0-b+2-win64.exe")
GetFromEnvironmentOrCache(
        NAME
            POSTFIX_OS_INSTALLER_FILENAME_LINUX
        DEFAULT
            linux
        DESCRIPTION
            "postfix for the installer file name when a Windows build is made (default linux): Ultimaker-Cura-5.0.0-b+2-linux.AppImage")
GetFromEnvironmentOrCache(
        NAME
            POSTFIX_OS_INSTALLER_FILENAME_MAC
        DEFAULT
            mac
        DESCRIPTION
            "postfix for the installer file name when a Windows build is made (default mac): Ultimaker-Cura-5.0.0-b+2-mac.dmg")

set(INSTALLER_BASE_FILENAME "Ultimaker-Cura")
if(NOT CURA_BUILDTYPE STREQUAL "")
    string(REPLACE " " "_" CURA_BUILDTYPE_NO_SPACES "${CURA_BUILDTYPE}")
    set(INSTALLER_BASE_FILENAME ${INSTALLER_BASE_FILENAME}-${CURA_BUILDTYPE_NO_SPACES})
endif()
set(INSTALLER_BASE_FILENAME ${INSTALLER_BASE_FILENAME}-${CURA_VERSION})

if(WIN32)
    set(INSTALLER_BASE_FILENAME ${INSTALLER_BASE_FILENAME}-${POSTFIX_OS_INSTALLER_FILENAME_WINDOWS})
endif()

if(LINUX)
    set(INSTALLER_BASE_FILENAME ${INSTALLER_BASE_FILENAME}-${POSTFIX_OS_INSTALLER_FILENAME_LINUX})
endif()

if(APPLE)
    set(INSTALLER_BASE_FILENAME ${INSTALLER_BASE_FILENAME}-${POSTFIX_OS_INSTALLER_FILENAME_MAC})
endif()

if(INSTALLER_EXT)
    set(INSTALLER_FILENAME ${INSTALLER_BASE_FILENAME}.${INSTALLER_EXT})
else()
    set(INSTALLER_FILENAME ${INSTALLER_BASE_FILENAME})
endif()

