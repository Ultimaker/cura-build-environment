ExternalProject_Add(NumpySTL
    URL https://github.com/WoLpH/numpy-stl/archive/v2.2.3.tar.gz
    URL_MD5 fbd2abc07fdbbb302a649f940f2ae4cc
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=numpystl-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET NumpySTL DEPENDS NumPy python-utils)
