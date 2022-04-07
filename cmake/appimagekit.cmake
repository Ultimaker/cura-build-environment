# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

set(_appimagetool_path "${CMAKE_INSTALL_PREFIX}/bin/appimagetool.AppImage")
set(_apprun_path "${CMAKE_INSTALL_PREFIX}/bin/AppRun")
set(_appimagetool_sha256 "d918b4df547b388ef253f3c9e7f6529ca81a885395c31f619d9aaf7030499a13")
set(_apprun_sha256 "e8f44f56bb23e105905850250d9d87fb1a5cf64211ad141b85864b1b7a092332")

#Put correct version in cura.desktop.
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/packaging/cura.desktop.in ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop @ONLY)

add_custom_target(AppImageKit ALL
    COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
    COMMAND curl -o "${_appimagetool_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage
    COMMAND echo "${_appimagetool_sha256}  ${_appimagetool_path}" | sha256sum --check
    COMMAND chmod a+x "${_appimagetool_path}"
    COMMAND curl -o "${_apprun_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/12/AppRun-x86_64
    COMMAND echo "${_apprun_sha256}  ${_apprun_path}" | sha256sum --check
    COMMAND chmod a+x "${_apprun_path}"
)

set(_appimage_filename "Ultimaker_Cura-${CURA_VERSION}.AppImage")
add_custom_target(packaging ALL
    COMMENT "Package into an AppImage file."
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/packaging/cura-icon_256x256.png ${ULTIMAKER_CURA_PATH}/cura-icon.png
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/cura.desktop ${ULTIMAKER_CURA_PATH}/cura.desktop
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/packaging/cura.sh ${ULTIMAKER_CURA_PATH}/AppRun
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/packaging/cura.appdata.xml ${ULTIMAKER_CURA_PATH}/cura.appdata.xml
    COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_CURRENT_BINARY_DIR}/${_appimage_filename}  #Remove old one if it existed.
    COMMAND ${_appimagetool_path} --appimage-extract-and-run ${ULTIMAKER_CURA_PATH} ${CMAKE_CURRENT_BINARY_DIR}/${_appimage_filename}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
add_dependencies(packaging pyinstaller AppImageKit)
