# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

if(SIGN_DMG)
    GetFromEnvironmentOrCache(
            NAME
                NOTARIZE_DMG
            DEFAULT
                TRUE
            BOOL
            DESCRIPTION
                "Notarize the dmg")

    if(NOTARIZE_DMG)
        GetFromEnvironmentOrCache(
                NAME
                    NOTARIZE_USER
                REQUIRED
                DESCRIPTION
                    "The Apple notarizing username")

        GetFromEnvironmentOrCache(
                NAME
                    NOTARIZE_PASSWORD
                REQUIRED
                DESCRIPTION
                    "The Apple password of the notarizing user")

        GetFromEnvironmentOrCache(
                NAME
                    ALTOOL_EXECUTABLE
                DEFAULT
                    /Applications/Xcode.app/Contents/Developer/usr/bin/altool
                FILEPATH
                DESCRIPTION
                    "The path to the altool executable")

        add_custom_target(notarize ALL COMMENT "Notarize the MacOS dmg")
        add_custom_command(
                TARGET
                    notarize
                WORKING_DIRECTORY
                    ${installer_DIR}
                COMMAND xcrun ${ALTOOL_EXECUTABLE} --notarize-app
                    --primary-bundle-id "${ULTIMAKER_CURA_DOMAIN}"
                    --username "${NOTARIZE_USER}"
                    --password "${NOTARIZE_PASSWORD}"
                    --file "${DMG_PATH}")
        add_dependencies(notarize signing pyinstaller install-python-requirements Cura create_installer_dir)
    endif()
endif()