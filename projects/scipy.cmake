if(NOT BUILD_OS_WINDOWS)
    set(scipy_build_command ${PYTHON_EXECUTABLE} setup.py build)
    set(scipy_install_command ${PYTHON_EXECUTABLE} setup.py install)

    if(BUILD_OS_OSX)
        set(scipy_build_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_build_command})
        set(scipy_install_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_install_command})
    endif()

    ExternalProject_Add(SciPy
        URL https://github.com/scipy/scipy/releases/download/v0.17.1/scipy-0.17.1.tar.gz
        URL_MD5 8987b9a3e3cd79218a0a423b21c8e4de
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
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-0.19.0-cp35-cp35m-win32.whl
            COMMENT "Installing SciPy"
        )
    SetProjectDependencies(TARGET PyQt DEPENDS Python)
    else()
        add_custom_target(SciPy
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-0.19.0-cp35-cp35m-win_amd64.whl
            COMMENT "Installing SciPy"
        )
    endif()
endif()

SetProjectDependencies(TARGET SciPy DEPENDS NumPy)
