ExternalProject_Add(MyPy
    URL https://files.pythonhosted.org/packages/d3/11/933d4f64d95bb3dae16162a115980293a9060f37af17e90e2b6bc848e508/mypy-0.610.tar.gz
    URL_HASH SHA256=f472645347430282d62d1f97d12ccb8741f19f1572b7cf30b58280e4e0818739
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET MyPy DEPENDS typed-ast)

