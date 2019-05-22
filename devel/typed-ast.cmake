ExternalProject_Add(typed-ast
    URL https://pypi.python.org/packages/5b/8c/742d31230f533662b34a335c09dc66bead07f0b964109fd432965c5b3fc4/typed-ast-0.6.3.tar.gz
    URL_MD5 1ada3bb2b75d0b2418143c2a912ea137
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET typed-ast DEPENDS Python)


