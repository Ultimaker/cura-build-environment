if(BUILD_OS_WINDOWS)
    if(BUILD_OS_WIN32)
        set(_openssl_os "VC-WIN32")
    else()
        set(_openssl_os "VC-WIN64A")
    endif()

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/openssl-1.0.1u.tar.gz
        URL_HASH SHA256=4312b4ca1215b6f2c97007503d80db80d5157f76f8f7d3febbe6b4c56ff26739
        CONFIGURE_COMMAND perl Configure ${_openssl_os} --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND ms\\do_ms.bat && nmake -f ms\\nt.mak
        INSTALL_COMMAND nmake -f ms\\nt.mak install
        BUILD_IN_SOURCE 1
    )
endif()
