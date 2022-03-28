if(BUILD_OS_OSX OR BUILD_OS_LINUX)
    ExternalProject_Add(zlib
        GIT_REPOSITORY https://github.com/madler/zlib.git
        GIT_TAG v1.2.11
        GIT_SHALLOW 1
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_CXX_STANDARD=17
                   -DAMD64=ON
    )
endif()
