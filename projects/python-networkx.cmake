ExternalProject_Add(PythonNetworkX
    URL https://github.com/networkx/networkx/archive/networkx-2.1.tar.gz
    URL_HASH SHA256=46aab610cdf15e680d944cafbf926a1d638f0cd2f1336b0f978b768a37d037f4
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=networkx-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonNetworkX DEPENDS Python)
