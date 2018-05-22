ExternalProject_Add(PythonChardet
    URL https://github.com/chardet/chardet/archive/3.0.4.tar.gz
    URL_HASH SHA256=d5620025cfca430f6c2e28ddbc87c3c66a5c82fa65570ae975c92911c2190189
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=chardet-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonChardet DEPENDS Python)
