#add_custom_target(setuptools)
#
#add_custom_command(COMMAND ${PYTHON_EXECUTABLE_PREFIXED} -m pip install -U setuptools
#                   TARGET setuptools)

ExternalProject_Add(setuptools
    URL https://pypi.python.org/packages/32/3c/e853a68b703f347f5ed86585c2dd2828a83252e1216c1201fa6f81270578/setuptools-26.1.1.tar.gz
    URL_MD5 0744ee90ad266fb117d59f94334185d0
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py install --old-and-unmanageable
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET setuptools DEPENDS Python)
