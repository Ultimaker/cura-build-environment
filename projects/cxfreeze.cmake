ExternalProject_Add(cx_Freeze
    #HG_REPOSITORY https://bitbucket.org/anthony_tuininga/cx_freeze
    URL https://bitbucket.org/anthony_tuininga/cx_freeze/get/tip.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)
