set(_googletest_url "https://github.com/google/googletest/archive/release-1.8.1.tar.gz")
set(_googletest_sha256 "9bf1fe5182a604b4135edc1a425ae356c9ad15e9b23f9f12a02e80184c3a249c")

ExternalProject_Add(GoogleTest
    URL ${_googletest_url}
        URL_HASH SHA256=${_googletest_sha256}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1
)

# Also need to build with MinGW on Windows
if(BUILD_OS_WINDOWS)
    ExternalProject_Add(GoogleTest-MinGW
        URL ${_googletest_url}
        URL_MD5 ${_googletest_md5sum}
        CMAKE_GENERATOR "MinGW Makefiles"
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_INSTALL_LIBDIR=lib-mingw
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )
endif()
