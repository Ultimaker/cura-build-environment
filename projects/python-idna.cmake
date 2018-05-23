ExternalProject_Add(PythonIdna
    URL https://github.com/kjd/idna/archive/v2.6.tar.gz
    URL_MD5 a835f2d123511e2a28c8ccda7a2da7fc
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=idna-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonIdna DEPENDS Python)
