ExternalProject_Add(PyTest
    URL https://pypi.python.org/packages/68/9c/c06dc051b39b817efd31e4c589df7780f7b287d96fab67e90be1f614fc0a/pytest-3.0.6.tar.gz
    URL_MD5 6639592fa430567d024189f097fcdbd7
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PyTest DEPENDS Py)
