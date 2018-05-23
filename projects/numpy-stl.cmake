ExternalProject_Add(NumpySTL
    URL https://github.com/WoLpH/numpy-stl/archive/v2.4.1.tar.gz
    URL_MD5 ab4d0a7620ad8c732f085eb4747fb938
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=numpystl-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET NumpySTL DEPENDS NumPy python-utils)
