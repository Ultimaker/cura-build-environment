if(NOT BUILD_ON_WINDOWS)
    ExternalProject_Add(PythonGeos
        URL https://github.com/grst/geos/archive/0.2.1.tar.gz
        URL_MD5 e1420e8f6ec643c29b46616faae61e01
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=geos-install.log
        BUILD_IN_SOURCE 1
    )

    if(BUILD_OS_LINUX)
        SetProjectDependencies(TARGET PythonGeos DEPENDS Python Geos)
    elseif(BUILD_OS_OSX)
        SetProjectDependencies(TARGET PythonGeos DEPENDS Python)
    endif()
endif()
