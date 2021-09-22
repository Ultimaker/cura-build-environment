if(NOT BUILD_OS_WINDOWS)
    # Fortran compiler is needed for OpenBLAS, but it does no check whether it is available.
    enable_language(Fortran)
    set(openblas_options DYNAMIC_ARCH=1 DYNAMIC_OLDER=1 NO_STATIC=1 TARGET=GENERIC)

    ExternalProject_Add(OpenBLAS
        URL https://github.com/xianyi/OpenBLAS/archive/v0.3.13.tar.gz
        URL_HASH SHA256=79197543b17cc314b7e43f7a33148c308b0807cd6381ee77f77e15acf3e6459e
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options}
        INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options} install
        BUILD_IN_SOURCE 1
    )
else()
    add_custom_target(OpenBLAS)
endif()

SetProjectDependencies(TARGET OpenBLAS)
