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

    add_custom_target(sign-dmg ALL COMMENT "Sign the MacOS dmg")
    add_custom_command(
            TARGET
                sign-dmg
            WORKING_DIRECTORY
                ${installer_DIR}
            COMMAND
                ${CODESIGN_EXECUTABLE} -s "${CODESIGN_IDENTITY}"
                --timestamp
                -i "${ULTIMAKER_CURA_DOMAIN}"
                "${DMG_PATH}"
            DEPENDS create-dmg pyinstaller install-python-requirements Cura create_installer_dir)
    add_dependencies(sign-dmg create-dmg pyinstaller install-python-requirements Cura create_installer_dir)
endif()