if(BUILD_OS_OSX)
    ExternalProject_Add(libxml
        URL ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
        URL_HASH SHA256=94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-lzma=${CMAKE_INSTALL_PREFIX} --with-sysroot=${CMAKE_OSX_SYSROOT}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxml DEPENDS xz Python)

    ExternalProject_Add_Step(libxml install_lxml
        COMMAND ${PYTHON_EXECUTABLE} -m pip install lxml==4.3.0
        DEPENDEES install
    )
elseif(BUILD_OS_LINUX)
    ExternalProject_Add(libxml
        URL ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
        URL_HASH SHA256=94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871
        CONFIGURE_COMMAND ./configure --disable-debug --disable-dependency-tracking --disable-silent-rules --prefix=${CMAKE_INSTALL_PREFIX} --with-lzma=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET libxml DEPENDS xz Python)

    ExternalProject_Add_Step(libxml install_lxml
        COMMAND ${PYTHON_EXECUTABLE} -m pip install lxml==4.3.0
        DEPENDEES install
    )
else()
    ExternalProject_Add(Python
        COMMAND ${PYTHON_EXECUTABLE} -m pip install lxml==4.3.0
        DEPENDEES upgrade_packages
    )
endif()
