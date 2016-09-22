ExternalProject_Add(PythonNetifaces
    URL https://pypi.python.org/packages/18/fa/dd13d4910aea339c0bb87d2b3838d8fd923c11869b1f6e741dbd0ff3bc00/netifaces-0.10.4.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=netifaces-install.log
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PythonNetifaces DEPENDS Python)

ExternalProject_Add(PythonSix
    URL https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=six-install.log
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PythonSix DEPENDS Python)

ExternalProject_Add(PythonZeroconf
    URL https://github.com/jstasiak/python-zeroconf/archive/0.17.5.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=zeroconf-install.log
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PythonZeroconf DEPENDS PythonNetifaces PythonSix)
