if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(PythonShapely
        URL https://github.com/Toblerity/Shapely/archive/1.6.4.post2.tar.gz
        URL_MD5 af55f98b3b05137fa9fe617104aec3e9
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=shapely-install.log
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PythonShapely DEPENDS Python NumPy PythonGeos)

else()
    ### MASSSIVE HACK TIME!!!!
    # It is currently effectively impossible to build SciPy on Windows without a proprietary compiler (ifort).
    # This means we need to use a pre-compiled binary version of Scipy. Since the only version of SciPy for
    # Windows available depends on numpy with MKL, we also need the binary package for that.
    if( BUILD_OS_WIN32 )
        add_custom_target(PythonShapely
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely‑1.6.4.post1‑cp35‑cp35m‑win32.whl
            COMMENT "Installing Python-Shapely"
        )
    else()
        add_custom_target(PythonShapely
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely‑1.6.4.post1‑cp35‑cp35m‑win_amd64.whl
            COMMENT "Installing Python-Shapely"
        )
    endif()
    SetProjectDependencies(TARGET PythonShapely DEPENDS Python NumPy)
endif()

