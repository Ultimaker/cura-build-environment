ExternalProject_Add(PythonNetifaces
    URL https://pypi.python.org/packages/18/fa/dd13d4910aea339c0bb87d2b3838d8fd923c11869b1f6e741dbd0ff3bc00/netifaces-0.10.4.tar.gz
    URL_MD5 36da76e2cfadd24cc7510c2c0012eb1e
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=netifaces-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonNetifaces DEPENDS Python)
