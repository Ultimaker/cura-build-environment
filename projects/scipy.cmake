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
    if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
        set(arch_dir "win-64")
    else()
        set(arch_dir "win-32")
    endif()

    ExternalProject_Add(SciPy
        URL https://repo.continuum.io/pkgs/free/${arch_dir}/scipy-0.18.1-np111py35_1.tar.bz2
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory Lib/site-packages ${CMAKE_INSTALL_PREFIX}/Lib/site-packages
        BUILD_IN_SOURCE 1
    )
endif()

SetProjectDependencies(TARGET SciPy DEPENDS NumPy)
