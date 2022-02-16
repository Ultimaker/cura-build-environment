if(BUILD_OS_OSX)
    ExternalProject_Add(sqlite3
        URL https://sqlite.org/2018/sqlite-autoconf-3260000.tar.gz
        URL_HASH SHA256=5daa6a3fb7d1e8c767cd59c4ded8da6e4b00c61d3b466d0685e35c4dd6d7bf5d
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(sqlite3
        URL https://sqlite.org/2018/sqlite-autoconf-3260000.tar.gz
        URL_HASH SHA256=5daa6a3fb7d1e8c767cd59c4ded8da6e4b00c61d3b466d0685e35c4dd6d7bf5d
        PATCH_COMMAND libtoolize
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make -j $(nproc)
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
endif()
