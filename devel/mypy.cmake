ExternalProject_Add(MyPy
    URL https://pypi.python.org/packages/a5/69/619d595becd335b3324174d565e2b219172da8b0fc5f93ed94d482738062/mypy-0.470.zip
    URL_MD5 ac4212fafb1de0abf30b7f1aace57c28
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET MyPy DEPENDS typed-ast)

