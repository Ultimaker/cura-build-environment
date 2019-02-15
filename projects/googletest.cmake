ExternalProject_Add(GoogleTest
    GIT_REPOSITORY https://github.com/google/googletest
    GIT_TAG origin/master
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1
)
