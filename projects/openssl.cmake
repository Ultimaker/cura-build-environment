if(BUILD_OS_WINDOWS)
    if(BUILD_OS_WIN32)
        set(_openssl_os "VC-WIN32")
        set(_openssl_build cd /d ${CMAKE_BINARY_DIR}\\OpenSSL-prefix\\src\\OpenSSL && ms\\do_nasm.bat && nmake -f ms\\ntdll.mak)
    else()
        set(_openssl_os "VC-WIN64A")
        set(_openssl_build cd /d ${CMAKE_BINARY_DIR}\\OpenSSL-prefix\\src\\OpenSSL && ms\\do_win64a.bat && nmake -f ms\\ntdll.mak)
    endif()

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/openssl-1.0.2k.tar.gz
        URL_HASH SHA256=6b3977c61f2aedf0f96367dcfb5c6e578cf37e7b8d913b4ecb6643c3cb88d8c0
        CONFIGURE_COMMAND cd /d ${CMAKE_BINARY_DIR}\\OpenSSL-prefix\\src\\OpenSSL && perl Configure ${_openssl_os} --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND cd /d ${CMAKE_BINARY_DIR}\\OpenSSL-prefix\\src\\OpenSSL && ${_openssl_build}
        INSTALL_COMMAND cd /d ${CMAKE_BINARY_DIR}\\OpenSSL-prefix\\src\\OpenSSL && nmake -f ms\\ntdll.mak install
        BUILD_IN_SOURCE 1
    )
else()
    return()
endif()
