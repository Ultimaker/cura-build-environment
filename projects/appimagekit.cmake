# Issue during build: https://github.com/probonopd/AppImageKit/issues/221
# Additional dependencies: libfuse-dev

ExternalProject_Add(AppImageKit
    GIT_REPOSITORY https://github.com/probonopd/AppImageKit.git
    GIT_TAG origin/master
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET AppImageKit)
