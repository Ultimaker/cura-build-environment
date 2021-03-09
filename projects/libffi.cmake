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
        URL ftp://sourceware.org/pub/libffi/libffi-3.3.tar.gz
        URL_HASH SHA256=72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056
        CONFIGURE_COMMAND ${_libffi_config_cmd}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
