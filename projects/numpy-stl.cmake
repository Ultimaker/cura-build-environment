ExternalProject_Add(NumpySTL
    URL https://github.com/WoLpH/numpy-stl/releases/download/v2.7.0/numpy-stl-v2.7.0.tar.xz
    URL_MD5 844dfd61af85ce216276debcf8730227
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=numpystl-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET NumpySTL DEPENDS NumPy python-utils)
