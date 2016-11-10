set(scipy_build_command ${PYTHON_EXECUTABLE} setup.py build)
set(scipy_install_command ${PYTHON_EXECUTABLE} setup.py install)

if(BUILD_OS_OSX)
    set(scipy_build_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_build_command})
    set(scipy_install_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_install_command})
endif()

# Using SciPy installed via pip on Windows
# Eg. "pip3 install scipy" or via .whl
# Other OSs will build it manually...
if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(SciPy
        URL https://github.com/scipy/scipy/releases/download/v0.17.1/scipy-0.17.1.tar.gz
        URL_MD5 8987b9a3e3cd79218a0a423b21c8e4de
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${scipy_build_command}
        INSTALL_COMMAND ${scipy_install_command}
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET SciPy DEPENDS NumPy)
endif()
