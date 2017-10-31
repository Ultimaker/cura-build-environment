ExternalProject_Add(PythonRequests
    URL https://github.com/requests/requests/archive/v2.18.4.tar.gz
    URL_MD5 ee668fdec015db44b3a85ae8c877d3d7
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=requests-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonRequests DEPENDS Python)
