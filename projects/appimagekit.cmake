if(BUILD_OS_LINUX)
    set(_appimagetool_path "${CMAKE_INSTALL_PREFIX}/bin/appimagetool.AppImage")
    set(_apprun_path "${CMAKE_INSTALL_PREFIX}/bin/AppRun")
	set(_appimagetool_sha256 "d918b4df547b388ef253f3c9e7f6529ca81a885395c31f619d9aaf7030499a13")
	set(_apprun_sha256 "e8f44f56bb23e105905850250d9d87fb1a5cf64211ad141b85864b1b7a092332")

    add_custom_target(AppImageKit ALL
        COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
	COMMAND curl -o "${_appimagetool_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage
	COMMAND echo "${_appimagetool_sha256}  ${_appimagetool_path}" | sha256sum --check
	COMMAND chmod a+x "${_appimagetool_path}"
	COMMAND curl -o "${_apprun_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/12/AppRun-x86_64
	COMMAND echo "${_apprun_sha256}  ${_apprun_sha256}" | sha256sum --check
	COMMAND chmod a+x "${_apprun_path}"
    )
endif()
