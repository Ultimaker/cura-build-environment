ExternalProject_Add(PythonCryptography
    URL https://github.com/pyca/cryptography/archive/2.2.2.tar.gz
    URL_MD5 29c5abdade0bdb558702b95512f0578c
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=cryptography-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonCryptography DEPENDS Python PythonPip)
