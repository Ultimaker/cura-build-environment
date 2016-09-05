ExternalProject_Add(NumPy
    URL http://downloads.sourceforge.net/project/numpy/NumPy/1.11.1/numpy-1.11.1.tar.gz
    URL_MD5 2f44a895a8104ffac140c3a70edbd450
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py install --prefix=${CMAKE_INSTALL_PREFIX} --old-and-unmanageable
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET NumPy DEPENDS setuptools OpenBLAS)
