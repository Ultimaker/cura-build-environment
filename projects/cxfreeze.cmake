ExternalProject_Add(cx_Freeze
    URL https://bitbucket.org/anthony_tuininga/cx_freeze/get/tip.tar.gz
    CONFIGURE_COMMAND ""
    PATCH_COMMAND hg import --no-commit ${CMAKE_CURRENT_LIST_DIR}/cxfreeze_exclude_self.patch
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)
