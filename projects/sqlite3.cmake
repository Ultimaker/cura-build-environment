if(BUILD_OS_OSX)
    ExternalProject_Add(sqlite3
        URL https://sqlite.org/2018/sqlite-autoconf-3260000.tar.gz
        URL_HASH SHA1=9af2df1a6da5db6e2ecf3f463625f16740e036e9
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(sqlite3
        URL https://sqlite.org/2018/sqlite-autoconf-3260000.tar.gz
        URL_HASH SHA1=9af2df1a6da5db6e2ecf3f463625f16740e036e9
        PATCH_COMMAND libtoolize
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET sqlite3 DEPENDS zlib)
endif()
