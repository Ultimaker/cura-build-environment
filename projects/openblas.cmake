if(BUILD_OS_LINUX)
    # Fortran compiler is needed for OpenBLAS, but it does no check whether it is available.
    enable_language(Fortran)
    set(openblas_options DYNAMIC_ARCH=1 NO_STATIC=1)

    ExternalProject_Add(OpenBLAS
        URL https://github.com/xianyi/OpenBLAS/archive/v0.2.15.tar.gz
        URL_MD5 b1190f3d3471685f17cfd1ec1d252ac9
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make ${openblas_options}
        INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options} install
        BUILD_IN_SOURCE 1
    )
elseif(BUILD_OS_WINDOWS)
#     enable_language(Fortran)
#     set(openblas_options DYNAMIC_ARCH=1 NO_STATIC=1)

    ExternalProject_Add(OpenBLAS
#         URL https://github.com/xianyi/OpenBLAS/archive/v0.2.15.tar.gz
        #URL_MD5 b1190f3d3471685f17cfd1ec1d252ac9
#         URL https://github.com/xianyi/OpenBLAS/archive/v0.2.19.tar.gz
        GIT_REPOSITORY https://github.com/xianyi/OpenBLAS
        GIT_TAG origin/develop
        PATCH_COMMAND git revert --no-commit --no-edit 9dbdc7b2
        CMAKE_GENERATOR "Visual Studio 14 2015"
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DDYNAMIC_ARCH=1 # -DBUILD_WITHOUT_LAPACK=OFF
#         BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config Release
#         INSTALL_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config Release --target INSTALL
#         CONFIGURE_COMMAND ""
#         BUILD_COMMAND make ${openblas_options}
#         INSTALL_COMMAND make PREFIX=${CMAKE_INSTALL_PREFIX} ${openblas_options} install
#         BUILD_IN_SOURCE 1
    )
else()
    add_custom_target(OpenBLAS)
endif()

SetProjectDependencies(TARGET OpenBLAS)
