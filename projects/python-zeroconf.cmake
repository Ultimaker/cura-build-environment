ExternalProject_Add(PythonZeroconf
    URL https://github.com/jstasiak/python-zeroconf/archive/0.20.0.tar.gz
    URL_MD5 7ef1d9e48a2b3b5d1abe77f0e5ce2197
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=zeroconf-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonZeroconf DEPENDS PythonPip PythonNetifaces PythonSix)
