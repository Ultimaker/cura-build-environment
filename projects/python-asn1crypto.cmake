ExternalProject_Add(PythonAsn1crypto
    URL https://github.com/wbond/asn1crypto/archive/0.24.0.tar.gz
    URL_MD5 e9df42b281e75fa924f54f19270a3b4a
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=asn1crypto-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonAsn1crypto DEPENDS Python PythonPip)
