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

set(DMG_PATH "${installer_DIR}/Ultimaker-Cura-${CURA_VERSION}-MacOS.dmg")

add_custom_target(create-dmg ALL COMMENT "Create the MacOS dmg")
add_custom_command(
        TARGET
            create-dmg
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
            ${ULTIMAKER_CURA_APP_PATH}
        DEPENDS pyinstaller install-python-requirements Cura create_installer_dir)
add_dependencies(create-dmg pyinstaller install-python-requirements Cura create_installer_dir)