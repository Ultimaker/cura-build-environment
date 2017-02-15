ExternalProject_Add(PySerial
    URL https://github.com/pyserial/pyserial/releases/download/v3.1.1/pyserial-3.1.1.tar.gz
    URL_MD5 2f72100de3e410b36d575e12e82e9d27
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pyserial-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PySerial DEPENDS Python)
