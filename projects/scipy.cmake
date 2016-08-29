
ExternalProject_Add(SciPy
    URL https://github.com/scipy/scipy/releases/download/v0.17.1/scipy-0.17.1.tar.gz
    URL_MD5 8987b9a3e3cd79218a0a423b21c8e4de
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET SciPy DEPENDS NumPy)
