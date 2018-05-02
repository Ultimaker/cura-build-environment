ExternalProject_Add(PythonCffi
    URL https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz
    URL_HASH SHA256=e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=cffi-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonCffi DEPENDS Python PythonPip)
