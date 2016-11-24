ExternalProject_Add(python-utils
    URL https://pypi.python.org/packages/24/f6/26474b0b52335864cf43a969987b7ab27ee14331def6ec82cbb8263bc937/python-utils-2.0.0.tar.gz
    URL_MD5 05d5fba0675e0ba3e3bf367e254d5369
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=pythonutils-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET python-utils DEPENDS Python)
