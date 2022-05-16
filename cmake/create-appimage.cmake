# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

set(INSTALLER_EXT AppImage)
include(${CMAKE_SOURCE_DIR}/cmake/installer-filename.cmake)

#Put correct version in cura.desktop.
configure_file(${CMAKE_SOURCE_DIR}/packaging/cura.desktop.in ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop @ONLY)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/apprun-attr.cmake" "file(COPY ${CMAKE_SOURCE_DIR}/packaging/AppRun DESTINATION ${ULTIMAKER_CURA_PATH} FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)")

add_custom_target(packaging ALL
    COMMENT "Package into an AppImage file."
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/apprun-attr.cmake
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/packaging/cura-icon_256x256.png ${ULTIMAKER_CURA_PATH}/cura-icon.png
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop ${ULTIMAKER_CURA_PATH}/cura.desktop
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/packaging/cura.appdata.xml ${ULTIMAKER_CURA_PATH}/cura.appdata.xml
    COMMAND ${CMAKE_COMMAND} -E remove ${installer_DIR}/dist/${INSTALLER_FILENAME}
    COMMAND appimagetool --appimage-extract-and-run ${ULTIMAKER_CURA_PATH}/ ${installer_DIR}/dist/${INSTALLER_FILENAME}
    WORKING_DIRECTORY ${ULTIMAKER_CURA_PATH})
add_dependencies(packaging pyinstaller)
