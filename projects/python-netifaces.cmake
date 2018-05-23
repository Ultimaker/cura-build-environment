ExternalProject_Add(PythonNetifaces
    URL https://files.pythonhosted.org/packages/81/39/4e9a026265ba944ddf1fea176dbb29e0fe50c43717ba4fcf3646d099fe38/netifaces-0.10.7.tar.gz
    URL_HASH SHA256=bd590fcb75421537d4149825e1e63cca225fd47dad861710c46bd1cb329d8cbd
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=netifaces-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonNetifaces DEPENDS Python)
