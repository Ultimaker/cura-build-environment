ExternalProject_Add(PythonPip
    URL https://files.pythonhosted.org/packages/ae/e8/2340d46ecadb1692a1e455f13f75e596d4eab3d11a57446f08259dee8f02/pip-10.0.1.tar.gz
    URL_HASH SHA256=f2bd08e0cd1b06e10218feaf6fef299f473ba706582eb3bd9d52203fdbd7ee68
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pip-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonPip DEPENDS Python)
