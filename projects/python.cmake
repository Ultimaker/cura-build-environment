# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.
#
# Sets up a virtual environment using the Python interpreter

if(NOT DEFINED Python_VERSION)
    set(Python_VERSION
            3.10
            CACHE STRING "Python Version" FORCE)
    message(STATUS "Setting Python version to ${Python_VERSION}. Set Python_VERSION if you want to compile against an other version.")
endif()
if(APPLE)
    set(Python_FIND_FRAMEWORK NEVER)
endif()
find_package(cpython ${Python_VERSION} QUIET COMPONENTS Interpreter)
if(NOT TARGET cpython::python)
    find_package(Python ${Python_VERSION} EXACT REQUIRED COMPONENTS Interpreter)
else()
    add_library(Python::Python ALIAS cpython::python)
    set(Python_SITEARCH "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages")
    set(Python_EXECUTABLE ${cpython_PACKAGE_FOLDER_RELEASE}/bin/python${exe_ext})
    set(ENV{PYTHONPATH} ${Python_SITEARCH})
endif()
message(STATUS "Using Python ${Python_VERSION}")

if(WIN32)
    set(ext .pyd)
    set(env_path_sep ";")
    set(exe_ext ".exe")
    set(exe_path "Scripts")
    set(lib_path "Lib")
else()
    set(ext .so)
    set(env_path_sep ":")
    set(exe_ext "")
    set(exe_path "bin")
    set(lib_path "lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}")
endif()

set(PYTHONPATH ${CMAKE_INSTALL_PREFIX}/${lib_path}/site-packages)
set(Python_VENV_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/${exe_path}/python${exe_ext})
set(Python_SITELIB_LOCAL ${CMAKE_INSTALL_PREFIX}/${lib_path}/site-packages/)

add_custom_target(create-virtual-env ALL COMMENT "Create Virtual Environment")
add_custom_command(
        TARGET create-virtual-env
        COMMAND ${Python_EXECUTABLE} -m venv ${CMAKE_INSTALL_PREFIX}
        MAIN_DEPENDENCY ${Python_EXECUTABLE})

add_custom_target(install-python-requirements ALL COMMENT "Install python requirements in virtual environment")
add_custom_command(
        TARGET install-python-requirements
        COMMAND ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHONPATH}" ${Python_VENV_EXECUTABLE} -m pip install --prefix ${CMAKE_INSTALL_PREFIX} --require-hashes -r  ${CMAKE_SOURCE_DIR}/projects/requirements.txt
        MAIN_DEPENDENCY ${Python_VENV_EXECUTABLE}
        DEPENDS create-virtual-env)

add_dependencies(install-python-requirements create-virtual-env)
