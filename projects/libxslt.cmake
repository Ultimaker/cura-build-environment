if(NOT BUILD_OS_WINDOWS)
    set(_libxslt_config_cmd
        ./configure --disable-dependency-tracking --disable-silent-rules
        --prefix=${CMAKE_INSTALL_PREFIX} --without-python
        --with-libxml-prefix=${CMAKE_INSTALL_PREFIX})

    if(BUILD_OS_OSX)
        if(CMAKE_OSX_SYSROOT)
            # On OS X, make sure the right OS X SDK is used.
            list(APPEND _libxslt_config_cmd --with-sysroot=${CMAKE_OSX_SYSROOT})
        endif()
    endif()

    ExternalProject_Add(libxslt
        URL ftp://xmlsoft.org/libxml2/libxslt-1.1.33.tar.gz
        URL_HASH SHA256=8e36605144409df979cab43d835002f63988f3dc94d5d3537c12796db90e38c8
        CONFIGURE_COMMAND ${_libxslt_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxslt DEPENDS libxml2)
endif()
