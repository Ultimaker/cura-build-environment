if(BUILD_OS_LINUX)
    # Download and install all AppImageKit tools into our prefix manually
    # Building AppImageKit v10 within a prefix does not work...
    set(_appimagekit_baseurl "https://github.com/AppImage/AppImageKit/releases/download/10")
    add_custom_target(AppImageKit ALL
        DEPENDS CMakeMinimal wget
        COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
        COMMAND wget -O ${CMAKE_INSTALL_PREFIX}/bin/appimaged ${_appimagekit_baseurl}/appimaged-x86_64.AppImage && chmod a+x ${CMAKE_INSTALL_PREFIX}/bin/appimaged
        COMMAND wget -O ${CMAKE_INSTALL_PREFIX}/bin/appimagetool ${_appimagekit_baseurl}/appimagetool-x86_64.AppImage && chmod a+x ${CMAKE_INSTALL_PREFIX}/bin/appimagetool
        COMMAND wget -O ${CMAKE_INSTALL_PREFIX}/bin/AppRun ${_appimagekit_baseurl}/AppRun-x86_64 && chmod a+x ${CMAKE_INSTALL_PREFIX}/bin/AppRun
        COMMAND wget -O ${CMAKE_INSTALL_PREFIX}/bin/runtime ${_appimagekit_baseurl}/runtime-x86_64 && chmod a+x ${CMAKE_INSTALL_PREFIX}/bin/runtime
    )
endif()
