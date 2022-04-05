# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.
#
# Sets up a virtual environment using the Python interpreter



set(pyinstaller_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/pyinstaller)
set(cura_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/cura_app.py)
set(curaengine_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/CuraEngine)
set(installer_DIR ${CMAKE_INSTALL_PREFIX}/installer)


if(APPLE AND DEFINED CODESIGN_IDENTITY)
        GetFromEnvironmentOrCache(
                NAME
                        CODESIGN_IDENTITY
                DESCRIPTION
                        "The name of the tag or branch to build for fdm_materials")
set(extra_pyinstaller_args "--codesign-identity \"${CODESIGN_IDENTITY}\" --osx-entitlements-file \"${CMAKE_SOURCE_DIR}\\signing\\cura.entitlements\" --osx-bundle-identifier \"nl.ultimaker.cura.dmg\" ")
else()
        set(extra_pyinstaller_args )
endif()

add_custom_target(create_installer_dir ALL COMMAND ${CMAKE_COMMAND} -E make_directory ${installer_DIR})
add_custom_target(Installer ALL COMMENT "Collect the build artifacts in a single installer")

add_custom_command(
        TARGET
            Installer
        WORKING_DIRECTORY
            ${installer_DIR}
        COMMAND
            ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHONPATH}" ${pyinstaller_EXECUTABLE} ${cura_EXECUTABLE} --collect-all cura --collect-all UM --hidden-import pySavitar --hidden-import pyArcus --hidden-import pynest2d --add-binary "${curaengine_EXECUTABLE}:." --add-data "${CMAKE_INSTALL_PREFIX}/lib/cura/plugins:plugins" --add-data "${CMAKE_INSTALL_PREFIX}/lib/uranium/plugins:plugins" --add-data "${CMAKE_INSTALL_PREFIX}/share/cura/resources:resources" --add-data "${CMAKE_INSTALL_PREFIX}/share/uranium/resources:resources" --add-data "${CMAKE_INSTALL_PREFIX}/lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}/site-packages/UM/Qt/qml/UM/:resources/qml/UM/" --windowed --clean --noconfirm --log-level INFO ${extra_pyinstaller_args} --name "Ultimaker-Cura"
        DEPENDS Python Cura create_installer_dir)
add_dependencies(projects create_installer_dir Installer)