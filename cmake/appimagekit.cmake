# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

set(INSTALLER_EXT AppImage)
include(${CMAKE_SOURCE_DIR}/cmake/installer-filename.cmake)

#Put correct version in cura.desktop.
configure_file(${CMAKE_SOURCE_DIR}/packaging/cura.desktop.in ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop @ONLY)

add_custom_target(packaging ALL
    COMMENT "Package into an AppImage file."
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/packaging/cura-icon_256x256.png ${ULTIMAKER_CURA_PATH}/cura-icon.png
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop ${ULTIMAKER_CURA_PATH}/cura.desktop
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/packaging/cura.sh ${ULTIMAKER_CURA_PATH}/AppRun
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/packaging/cura.appdata.xml ${ULTIMAKER_CURA_PATH}/cura.appdata.xml
    COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_CURRENT_BINARY_DIR}/${INSTALLER_FILENAME}
    COMMAND appimage ${ULTIMAKER_CURA_PATH} ${CMAKE_CURRENT_BINARY_DIR}/${INSTALLER_FILENAME}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
add_dependencies(packaging pyinstaller)
