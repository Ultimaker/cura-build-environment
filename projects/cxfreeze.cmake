# Using cx_Freeze installed via pip on Windows
# Eg. "pip3 install cx_Freeze" or via .whl
# Other OSs will build it manually...
ExternalProject_Add(cx_Freeze
    #HG_REPOSITORY https://bitbucket.org/anthony_tuininga/cx_freeze
    URL https://bitbucket.org/anthony_tuininga/cx_freeze/get/tip.tar.gz
    # URL_HASH not set here, as we are downloading from 'tip'
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=cxfreeze-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)

