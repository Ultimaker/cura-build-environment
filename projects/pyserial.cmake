ExternalProject_Add(PySerial
    URL https://github.com/pyserial/pyserial/archive/v3.4.tar.gz
    URL_MD5 fc00727ed9cf3a31b7a296a4d42f6afc
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pyserial-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PySerial DEPENDS Python)
