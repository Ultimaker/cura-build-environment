if(NOT BUILD_OS_WINDOWS)
    set(_openssl_build make depend && make -j ${N_PROC})
    set(_openssl_install make install)
    if(BUILD_OS_LINUX)
        set(_openssl_configure perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} no-ssl2 no-ssl3 no-zlib shared enable-cms linux-x86_64 enable-ec_nistp_64_gcc_128)
    elseif(BUILD_OS_OSX)
        set(_openssl_configure perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} no-ssl2 no-ssl3 no-zlib shared enable-cms darwin64-x86_64-cc enable-ec_nistp_64_gcc_128)
    endif()

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/openssl-1.1.1l.tar.gz
        URL_HASH SHA256=0b7a3e5e59c34827fe0c3a74b7ec8baef302b98fa80088d7f9153aa16fa76bd1
        CONFIGURE_COMMAND ${_openssl_configure}
        BUILD_COMMAND ${_openssl_build}
        INSTALL_COMMAND ${_openssl_install}
        BUILD_IN_SOURCE 1
    )
endif()
