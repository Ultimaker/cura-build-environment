ExternalProject_Add(CppUnit
    URL https://sourceforge.net/projects/cppunit/files/cppunit/1.12.1/cppunit-1.12.1.tar.gz
    URL_MD5 bd30e9cf5523cdfc019b94f5e1d7fd19
    BUILD_COMMAND make
    INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Astroid DEPENDS Python)
