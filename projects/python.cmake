# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.
#
# Sets up a virtual environment using the Python interpreter

if(WIN32)
    set(ext .pyd)
    set(env_path_sep ";")
else()
    set(ext .so)
    set(env_path_sep ":")
endif()


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
    set(Python_EXECUTABLE ${cpython_PACKAGE_FOLDER_RELEASE}/bin/python3)
    set(ENV{PYTHONPATH} ${Python_SITEARCH})
endif()
message(STATUS "Using Python ${Python_VERSION}")

set(PYTHONPATH ${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages)
add_custom_target(Python ALL COMMENT "Create Virtual Environment")

add_custom_command(
        TARGET Python
        COMMAND ${Python_EXECUTABLE} -m venv ${CMAKE_INSTALL_PREFIX}
        COMMAND ${CMAKE_COMMAND} -E env "PYTHONPATH=${PYTHONPATH}" ${Python_EXECUTABLE} -m pip install --prefix ${CMAKE_INSTALL_PREFIX} --require-hashes -r  ${CMAKE_SOURCE_DIR}/projects/requirements.txt
        MAIN_DEPENDENCY Python)
add_dependencies(projects Python)
