# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            CREATE_DMG_EXECUTABLE
        DEFAULT
            /usr/local/bin/create-dmg
        FILEPATH
        DESCRIPTION
            "The path to the create-dmg executable")

GetFromEnvironmentOrCache(
        NAME
            REZ_EXECUTABLE
        DEFAULT
            /Library/Developer/CommandLineTools/usr/bin/Rez
        FILEPATH
        DESCRIPTION
            "The path to the Rez (Resource compiler)")

set(INSTALLER_EXT dmg)
include(${CMAKE_SOURCE_DIR}/cmake/installer-filename.cmake)
set(DMG_PATH ${installer_DIR}/${INSTALLER_FILENAME})

add_custom_target(packaging ALL COMMENT "Create the MacOS dmg")
add_custom_command(
        TARGET
            packaging
        WORKING_DIRECTORY
            ${installer_DIR}
        COMMAND
            ${CREATE_DMG_EXECUTABLE} --window-pos 640 360
            --volicon "${CMAKE_SOURCE_DIR}/packaging/VolumeIcons_Cura.icns"
            --window-size 690 503
            --icon-size 90
            --icon "Ultimaker-Cura.app" 169 272
            --app-drop-link 520 272
            --eula "${CMAKE_SOURCE_DIR}/packaging/cura_license.txt"
            --background "${CMAKE_SOURCE_DIR}/packaging/cura_background_dmg.png"
            --rez ${REZ_EXECUTABLE}
            ${DMG_PATH}
            ${ULTIMAKER_CURA_APP_PATH})
add_dependencies(packaging pyinstaller install-python-requirements Cura create_installer_dir)