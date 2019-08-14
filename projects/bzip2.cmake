if(BUILD_OS_LINUX)
    ExternalProject_Add(bzip2-static
        URL https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
        URL_HASH SHA256=ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make -f Makefile PREFIX=${CMAKE_INSTALL_PREFIX}
        INSTALL_COMMAND make -f Makefile install PREFIX=${CMAKE_INSTALL_PREFIX}
        BUILD_IN_SOURCE 1
    )
    # bzip2 "Makefile-libbz2_so" builds the dynamic library but doesn't include any installation targets. The patch
    # file "bzip2_shared.patch" adds a install target so the dynamic libraries can be installed.
    ExternalProject_Add(bzip2-shared
        URL https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
        URL_HASH SHA256=ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269
        PATCH_COMMAND patch Makefile-libbz2_so ${CMAKE_SOURCE_DIR}/projects/bzip2_shared.patch
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make -f Makefile-libbz2_so PREFIX=${CMAKE_INSTALL_PREFIX}
        INSTALL_COMMAND make -f Makefile-libbz2_so install PREFIX=${CMAKE_INSTALL_PREFIX}
        BUILD_IN_SOURCE 1
    )
endif()
