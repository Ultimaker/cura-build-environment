if(NOT BUILD_OS_WINDOWS)
    set(_libffi_config_cmd
        ./configure --disable-dependency-tracking --disable-silent-rules --enable-portable-binary
                    --prefix=${CMAKE_INSTALL_PREFIX}
        )

    if(BUILD_OS_OSX)
        if(CMAKE_OSX_SYSROOT)
            # On OS X, make sure the right OS X SDK is used.
            list(APPEND _libffi_config_cmd --with-sysroot=${CMAKE_OSX_SYSROOT})
        endif()
    endif()

    ExternalProject_Add(libffi
        URL ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
        URL_HASH SHA256=d06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37
        CONFIGURE_COMMAND ${_libffi_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
