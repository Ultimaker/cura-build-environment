ExternalProject_Add(PythonSix
    URL https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz
    URL_HASH SHA256=70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=six-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET PythonSix DEPENDS Python)
