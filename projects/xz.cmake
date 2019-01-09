if(BUILD_OS_OSX)
    ExternalProject_Add(xz
        URL https://sourceforge.net/projects/lzmautils/files/xz-5.2.4.tar.gz
        URL_HASH SHA256=b512f3b726d3b37b6dc4c8570e137b9311e7552e8ccbab4d39d47ce5f4177145
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(xz
        URL https://sourceforge.net/projects/lzmautils/files/xz-5.2.4.tar.gz
        URL_HASH SHA256=b512f3b726d3b37b6dc4c8570e137b9311e7552e8ccbab4d39d47ce5f4177145
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
