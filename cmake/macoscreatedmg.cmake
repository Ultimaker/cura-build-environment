# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

add_custom_target(create-dmg ALL COMMENT "Create the dmg from the pyinstaller output")

GetFromEnvironmentOrCache(
        NAME
            CREATE_DMG_EXECUTABLE
        DEFAULT
            /usr/local/bin/create-dmg
        DESCRIPTION
            "The path to the create-dmg executable")

GetFromEnvironmentOrCache(
        NAME
            REX_EXECUTABLE
        DEFAULT
            /Library/Developer/CommandLineTools/usr/bin/Rez
        DESCRIPTION
            "The path to the Rez (Resource compiler)")

add_custom_command(
        TARGET
            create-dmg
        WORKING_DIRECTORY
            ${installer_DIR}
        COMMAND
            ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHONPATH}" ${CREATE_DMG_EXECUTABLE} --window-pos 640 360
            --volicon "${CMAKE_SOURCE_DIR}/packaging/VolumeIcons_Cura.icns"
            --window-size 690 503
            --icon-size 90
            --icon "Ultimaker-Cura.app" 169 272
            --app-drop-link 520 272
            --eula "${CMAKE_SOURCE_DIR}/packaging/cura_license.txt"
            --background "$source_dir/packaging/cura_background_dmg.png"
            --rez /Library/Developer/CommandLineTools/usr/bin/Rez
            "${installer_DIR}"
            "${installer_DIR}/dist/Ultimaker-Cura.app"
        DEPENDS pyinstaller install-python-requirements Cura create_installer_dir)
add_dependencies(create-dmg pyinstaller install-python-requirements Cura create_installer_dir)