if(BUILD_OS_LINUX)
    set(_appimagetool_path "${CMAKE_INSTALL_PREFIX}/bin/appimagetool.AppImage")
    set(_apprun_path "${CMAKE_INSTALL_PREFIX}/bin/AppRun")

    add_custom_target(AppImageKit ALL
        COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
	COMMAND curl -o "${_appimagetool_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/11/appimagetool-x86_64.AppImage
	COMMAND chmod a+x "${_appimagetool_path}"
	COMMAND curl -o "${_apprun_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/11/AppRun-x86_64
	COMMAND chmod a+x "${_apprun_path}"
    )
endif()
