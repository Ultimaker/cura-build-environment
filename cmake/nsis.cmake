# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

# Only NSIS needs to have arduino and vcredist
include(InstallRequiredSystemLibraries)
install(PROGRAMS ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS} DESTINATION "." COMPONENT VC_Runtime_Libs)
add_custom_target(packaging ALL COMMENT "Package into a NSIS installer.")

set(INSTALLER_EXT exe)
include(${CMAKE_SOURCE_DIR}/cmake/installer-filename.cmake)

add_custom_command(
        TARGET
            packaging
        WORKING_DIRECTORY
            ${installer_DIR}/dist
        COMMAND
            ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/packaging/NSIS/nsis-configurator.py
            ${ULTIMAKER_CURA_PATH}
            ${CMAKE_SOURCE_DIR}/packaging/NSIS/Ultimaker-Cura.nsi.jinja
            "Ultimaker Cura"
            "Ultimaker-Cura.exe"
            ${CURA_VERSION_MAJOR}
            ${CURA_VERSION_MINOR}
            ${CURA_VERSION_PATCH}
            ${CURA_VERSION_BUILD}
            "Ultimaker B.V."
            "https://ultimaker.com/software/ultimaker-cura"
            ${CMAKE_SOURCE_DIR}/packaging/cura_license.txt
            LZMA
            ${CMAKE_SOURCE_DIR}/packaging/cura_banner_nsis.bmp
            ${CMAKE_SOURCE_DIR}/packaging/Cura.ico
            ${installer_DIR}/dist/${INSTALLER_FILENAME}
        COMMAND
            makensis /V2 /P4 ${installer_DIR}/dist/Ultimaker-Cura.nsi
        COMMENT  "Package into a NSIS installer."
        )
add_dependencies(packaging pyinstaller)