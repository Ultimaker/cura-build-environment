ExternalProject_Add(cx_Freeze
    HG_REPOSITORY https://bitbucket.org/anthony_tuininga/cx_freeze
    CONFIGURE_COMMAND ""
    PATCH_COMMAND hg import --no-commit ${CMAKE_CURRENT_LIST_DIR}/cxfreeze_exclude_self.patch
    BUILD_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE_PREFIXED} setup.py install --old-and-unmanageable
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)
