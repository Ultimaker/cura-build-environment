ExternalProject_Add(PythonZeroconf
    URL https://github.com/jstasiak/python-zeroconf/archive/0.17.6.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=zeroconf-install.log
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PythonZeroconf DEPENDS PythonNetifaces PythonSix)
