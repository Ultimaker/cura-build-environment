set(_patch_command "")
if(BUILD_OS_OSX)
    set(_patch_command patch cx_Freeze/freezer.py ${CMAKE_SOURCE_DIR}/projects/cxfreeze_exclude_a.patch)
endif()

set(_url "https://github.com/anthony-tuininga/cx_Freeze/archive/5.0.tar.gz")
if(BUILD_OS_WINDOWS)
    set(_url https://github.com/anthony-tuininga/cx_Freeze/archive/5.0.1.tar.gz)
endif()

ExternalProject_Add(cx_Freeze
    URL ${_url}
    PATCH_COMMAND ${_patch_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${Python3_EXECUTABLE} setup.py build
    INSTALL_COMMAND ${Python3_EXECUTABLE} setup.py install --single-version-externally-managed --record=cxfreeze-install.log
    BUILD_IN_SOURCE 1
)
SetProjectDependencies(TARGET cx_Freeze DEPENDS Python)

