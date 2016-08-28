ExternalProject_Add(PythonZeroconf
    URL https://github.com/jstasiak/python-zeroconf/archive/0.17.5.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --old-and-unmanageable
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PythonZeroconf DEPENDS PythonNetifaces)
