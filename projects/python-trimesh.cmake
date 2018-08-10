ExternalProject_Add(PythonTrimesh
    URL https://files.pythonhosted.org/packages/fc/6d/da9061e54938d312faa789e9ed929f05352378032e548361943cbf951217/trimesh-2.31.45.tar.gz
    URL_HASH SHA256=f115a211c200d4346da0233319dbd2bb7ea3539004c93b9ff588bea3c4e62c36
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=trimesh-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonTrimesh DEPENDS Python NumPy Scipy PythonNetworkX)
