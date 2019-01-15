if(NOT BUILD_OS_WINDOWS)
    set(_libxml2_config_cmd
        ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules
        --prefix=${CMAKE_INSTALL_PREFIX} --without-python
        )

    if(BUILD_OS_OSX)
        if(CMAKE_OSX_SYSROOT)
            # On OS X, make sure the right OS X SDK is used.
            list(APPEND _libxml2_config_cmd --without-lzma --with-sysroot=${CMAKE_OSX_SYSROOT})
        endif()
    else()
        list(APPEND _libxml2_config_cmd --with-lzma=${CMAKE_INSTALL_PREFIX})
    endif()

    ExternalProject_Add(libxml2
        URL ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
        URL_HASH SHA256=94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871
        CONFIGURE_COMMAND ${_libxml2_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxml2 DEPENDS xz)
endif()
