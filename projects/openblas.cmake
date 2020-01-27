if(NOT BUILD_OS_WINDOWS)
    # Fortran compiler is needed for OpenBLAS, but it does no check whether it is available.
    enable_language(Fortran)
    set(openblas_options DYNAMIC_ARCH=1 NO_STATIC=1 TARGET=HASWELL)

    ExternalProject_Add(OpenBLAS
        URL https://github.com/xianyi/OpenBLAS/archive/v0.3.7.tar.gz
        URL_MD5 5cd4ff3891b66a59e47af2d14cde4056
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options}
        INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options} install
        BUILD_IN_SOURCE 1
    )
else()
    add_custom_target(OpenBLAS)
endif()

SetProjectDependencies(TARGET OpenBLAS)
