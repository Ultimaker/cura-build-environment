# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.
#
# Sets up a virtual environment using the Python interpreter


set(pyinstaller_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/${exe_path}/pyinstaller)
set(cura_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/cura_app.py)
set(curaengine_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/CuraEngine${exe_ext})
set(installer_DIR "${CMAKE_INSTALL_PREFIX}/installer")
set(ULTIMAKER_CURA_PATH "${installer_DIR}/dist/Ultimaker-Cura")

if (APPLE)
    set(ULTIMAKER_CURA_APP_PATH "${ULTIMAKER_CURA_PATH}.app")
    GetFromEnvironmentOrCache(
            NAME
                SIGN_DMG
            DEFAULT
                TRUE
            BOOL
            DESCRIPTION
                "Sign the dmg")
    if (SIGN_DMG)
        GetFromEnvironmentOrCache(
                NAME
                    CODESIGN_IDENTITY
                REQUIRED
                DESCRIPTION
                    "The Apple codesign identity")
    GetFromEnvironmentOrCache(
            NAME
                ULTIMAKER_CURA_DOMAIN
            DEFAULT
                nl.ultimaker.cura.dmg
            DESCRIPTION
                "The Ultimaker Cura domain to be used (usually reversed)")
        set(extra_pyinstaller_args --codesign-identity "${CODESIGN_IDENTITY}" --osx-entitlements-file "${CMAKE_SOURCE_DIR}/signing/cura.entitlements" --osx-bundle-identifier "${ULTIMAKER_CURA_DOMAIN}" )
    endif ()
else ()
    set(extra_pyinstaller_args)
endif ()

add_custom_target(create_installer_dir ALL COMMAND ${CMAKE_COMMAND} -E make_directory ${installer_DIR})
add_custom_target(pyinstaller ALL COMMENT "Collect the build artifacts in a single installer")
include(${CMAKE_SOURCE_DIR}/cmake/os.cmake)
add_custom_command(
        TARGET
            pyinstaller
        WORKING_DIRECTORY
            ${installer_DIR}
        COMMAND
            ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHONPATH}" ${pyinstaller_EXECUTABLE} ${cura_EXECUTABLE}
                --collect-all cura
                --collect-all UM
                --collect-all serial #Used only in plug-ins.
                --collect-all Charon
                --hidden-import pySavitar
                --hidden-import pyArcus
                --hidden-import pynest2d
                --hidden-import PyQt6.QtNetwork
                --hidden-import logging.handlers
                --hidden-import zeroconf
                --add-binary "${curaengine_EXECUTABLE}${env_path_sep}."
                --add-data "${CMAKE_INSTALL_PREFIX}/${lib_path}/cura/plugins${env_path_sep}plugins"
                --add-data "${CMAKE_INSTALL_PREFIX}/${lib_path}/uranium/plugins${env_path_sep}plugins"
                --add-data "${CMAKE_INSTALL_PREFIX}/share/cura/resources${env_path_sep}resources"
                --add-data "${CMAKE_INSTALL_PREFIX}/share/uranium/resources${env_path_sep}resources"
                --add-data "${Python_SITELIB_LOCAL}/UM/Qt/qml/UM/${env_path_sep}resources/qml/UM/"
                --windowed --clean --noconfirm --log-level INFO ${extra_pyinstaller_args}
                --name "Ultimaker-Cura")
add_dependencies(pyinstaller create_installer_dir Cura fdm_materials cura-binary-data)