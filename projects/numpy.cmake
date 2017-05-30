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
    if( BUILD_OS_WIN32 )
        add_custom_target(NumPy
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.11.3+mkl-cp35-cp35m-win32.whl
            COMMENT "Installing NumPy"
        )
    else()
        add_custom_target(NumPy
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.11.3+mkl-cp35-cp35m-win_amd64.whl
            COMMENT "Installing NumPy"
        )
    endif()
endif()

SetProjectDependencies(TARGET NumPy DEPENDS Python OpenBLAS)
