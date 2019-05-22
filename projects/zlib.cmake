if(BUILD_OS_OSX OR BUILD_OS_LINUX)
    ExternalProject_Add(zlib
        URL https://www.zlib.net/zlib-1.2.11.tar.gz
        URL_HASH SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1
        CONFIGURE_COMMAND ./configure --64 --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
