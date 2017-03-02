if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(NumPy
        URL http://downloads.sourceforge.net/project/numpy/NumPy/1.11.1/numpy-1.11.1.tar.gz
        URL_MD5 2f44a895a8104ffac140c3a70edbd450
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=numpy-install.log
        BUILD_IN_SOURCE 1
    )
else()
    ### MASSSIVE HACK TIME!!!!
    # It is currently effectively impossible to build SciPy on Windows without a proprietary compiler (ifort).
    # This means we need to use a pre-compiled binary version of Scipy. Since the only version of SciPy for
    # Windows available depends on numpy with MKL, we also need the binary package for that.
    if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
        set(arch_dir "win-64")
    else()
        set(arch_dir "win-32")
    endif()

    ExternalProject_Add(NumPy
        URL https://repo.continuum.io/pkgs/free/${arch_dir}/numpy-1.11.3-py35_0.tar.bz2
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory Lib/site-packages ${CMAKE_INSTALL_PREFIX}/Lib/site-packages
        BUILD_IN_SOURCE 1
    )

    ExternalProject_Add(MKL
        URL https://repo.continuum.io/pkgs/free/${arch_dir}/mkl-2017.0.1-0.tar.bz2
        DEPENDS NumPy
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory Library/bin ${CMAKE_INSTALL_PREFIX}/Lib/site-packages/numpy/core
        BUILD_IN_SOURCE 1
    )
endif()

SetProjectDependencies(TARGET NumPy DEPENDS Python OpenBLAS)
