if(NOT BUILD_OS_WINDOWS)
    set(scipy_build_command ${PYTHON_EXECUTABLE} setup.py build)
    set(scipy_install_command ${PYTHON_EXECUTABLE} setup.py install)

    if(BUILD_OS_OSX)
        set(scipy_build_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_build_command})
        set(scipy_install_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_install_command})
    endif()

    ExternalProject_Add(SciPy
        URL https://github.com/scipy/scipy/releases/download/v1.0.1/scipy-1.0.1.tar.gz
        URL_MD5 47e90ddfb5af8f23890c02a967e9a029
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${scipy_build_command}
        INSTALL_COMMAND ${scipy_install_command}
        BUILD_IN_SOURCE 1
    )
else()
    ### MASSSIVE HACK TIME!!!!
    # It is currently effectively impossible to build SciPy on Windows without a proprietary compiler (ifort).
    # This means we need to use a pre-compiled binary version of Scipy.
    if( BUILD_OS_WIN32 )
        add_custom_target(SciPy
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-1.0.1-cp35-cp35m-win32.whl
            COMMENT "Installing SciPy"
        )
    SetProjectDependencies(TARGET PyQt DEPENDS Python)
    else()
        add_custom_target(SciPy
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-1.0.1-cp35-cp35m-win_amd64.whl
            COMMENT "Installing SciPy"
        )
    endif()
endif()

SetProjectDependencies(TARGET SciPy DEPENDS NumPy)
