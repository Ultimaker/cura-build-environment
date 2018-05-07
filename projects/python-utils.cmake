ExternalProject_Add(python-utils
    URL https://files.pythonhosted.org/packages/30/95/d01fbd09ced38a16b7357a1d6cefe1327b9273885bffd6371cbec3e23af7/python-utils-2.3.0.tar.gz
    URL_HASH SHA256=34aaf26b39b0b86628008f2ae0ac001b30e7986a8d303b61e1357dfcdad4f6d3
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pythonutils-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET python-utils DEPENDS Python)
