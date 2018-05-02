ExternalProject_Add(PythonJwt
    URL https://github.com/jpadilla/pyjwt/archive/1.6.1.tar.gz
    URL_MD5 0e37e565e095f7b2bb8eac949c8b92d5
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pyjwt-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonJwt DEPENDS Python PythonPip PythonCryptography)
