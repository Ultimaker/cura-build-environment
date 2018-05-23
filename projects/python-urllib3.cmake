ExternalProject_Add(PythonUrllib3
    URL https://github.com/urllib3/urllib3/archive/1.22.tar.gz
    URL_HASH SHA256=dd60d4104b871943e06be69e296e97ede9d42edf6ba534f0268aee932a601e2a
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=urllib3-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonUrllib3 DEPENDS Python)
