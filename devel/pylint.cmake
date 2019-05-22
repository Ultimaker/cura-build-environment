ExternalProject_Add(PyLint
    URL https://pypi.python.org/packages/6b/03/840420e0e5d01d532646e1e6144c30a57360a396e0821e1bb9d209dde563/pylint-1.6.5.tar.gz
    URL_MD5 31da2185bf59142479e4fa16d8a9e347
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PyLint DEPENDS Astroid isort)
