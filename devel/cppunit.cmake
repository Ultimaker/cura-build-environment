if (NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(CppUnit
        URL https://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/cppunit-1.12.1.tar.gz
        URL_MD5 bd30e9cf5523cdfc019b94f5e1d7fd19
        CONFIGURE_COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-doxygen=no --enable-dot=no --enable-html-docs=no LDFLAGS=-ldl
        BUILD_IN_SOURCE 1
    )
endif()
