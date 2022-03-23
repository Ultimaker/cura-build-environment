if(BUILD_OS_OSX)
    ExternalProject_Add(xz
        GIT_REPOSITORY https://git.tukaani.org/xz.git
        GIT_TAG v5.2.4
        CONFIGURE_COMMAND ./autogen.sh && ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make -j ${N_PROC}
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(xz
        GIT_REPOSITORY https://git.tukaani.org/xz.git
        GIT_TAG v5.2.4
        CONFIGURE_COMMAND ./autogen.sh && ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make -j ${N_PROC}
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
