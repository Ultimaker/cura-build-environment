if(BUILD_OS_OSX)
    ExternalProject_Add(libxml
        URL https://github.com/GNOME/libxml2/archive/v2.9.9.tar.gz
        URL_HASH SHA256=d673f0284cec867ee00872a8152e0c3c09852f17fd9aa93f07579a37534f0bfe
        CONFIGURE_COMMAND ./autogen.sh --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-lzma=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxml xz)
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(libxml
        URL https://github.com/GNOME/libxml2/archive/v2.9.9.tar.gz
        URL_HASH SHA256=d673f0284cec867ee00872a8152e0c3c09852f17fd9aa93f07579a37534f0bfe
        CONFIGURE_COMMAND ./autogen.sh --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-lzma=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxml xz)
endif()
