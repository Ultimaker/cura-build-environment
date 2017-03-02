
ExternalProject_Add(cx_Freeze
    URL https://github.com/anthony-tuininga/cx_Freeze/archive/5.0.tar.gz
    PATCH_COMMAND patch cx_Freeze/freezer.py ${CMAKE_SOURCE_DIR}/projects/cxfreeze_exclude_a.patch
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=cxfreeze-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)

