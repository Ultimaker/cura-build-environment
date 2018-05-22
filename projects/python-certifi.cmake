ExternalProject_Add(PythonCertifi
    URL https://github.com/certifi/python-certifi/archive/2018.04.16.tar.gz
    URL_HASH SHA256=38671b7ce3524c376183da920d7a441edff86ffc667a715fce79133e76e103fd
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=certifi-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonCertifi DEPENDS Python)
