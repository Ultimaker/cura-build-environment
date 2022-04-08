# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

if(SIGN_DMG)
    GetFromEnvironmentOrCache(
            NAME
                CODESIGN_EXECUTABLE
            DEFAULT
                /usr/bin/codesign
            FILEPATH
            DESCRIPTION
                "The path to the codesign executable")

    add_custom_target(signing ALL COMMENT "Sign the MacOS dmg")
    add_custom_command(
            TARGET
                signing
            WORKING_DIRECTORY
                ${installer_DIR}
            COMMAND
                ${CODESIGN_EXECUTABLE} -s "${CODESIGN_IDENTITY}"
                --timestamp
                -i "${ULTIMAKER_CURA_DOMAIN}"
                "${DMG_PATH}")
    add_dependencies(signing packaging pyinstaller install-python-requirements Cura create_installer_dir)
endif()