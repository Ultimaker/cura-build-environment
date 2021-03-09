if(NOT BUILD_OS_WINDOWS)
    # Fortran compiler is needed for OpenBLAS, but it does no check whether it is available.
    enable_language(Fortran)
    set(openblas_options DYNAMIC_ARCH=1 NO_STATIC=1 TARGET=HASWELL)

    ExternalProject_Add(OpenBLAS
        GIT_REPOSITORY https://github.com/xianyi/OpenBLAS.git
        GIT_TAG v0.3.13
        GIT_SHALLOW TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options}
        INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options} install
        BUILD_IN_SOURCE 1
    )
else()
    add_custom_target(OpenBLAS)
endif()

SetProjectDependencies(TARGET OpenBLAS)
