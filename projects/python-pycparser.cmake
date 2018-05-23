ExternalProject_Add(PythonPycparser
    URL https://github.com/eliben/pycparser/archive/release_v2.18.tar.gz
    URL_MD5 c609e8b0e3941d3f32d2fd13fba803e1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pycparser-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonPycparser DEPENDS Python)
