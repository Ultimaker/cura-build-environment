# Copyright 2022 Ultimaker

# Setting the MACOSX_DEPLOYMENT_TARGET needs to be done before the first project() call. Setting this value should also
# take care of the CMAKE_OSX_SYSROOT. The variable is ignored on non-Apple systems.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(GetFromEnvironmentOrCache)
GetFromEnvironmentOrCache(
        NAME
            CMAKE_OSX_DEPLOYMENT_TARGET
        DESCRIPTION
            "Specify the minimum version of the target platform (e.g. macOS or iOS)")

project(cura-build-environment)

cmake_minimum_required(VERSION 3.18)

include(ProcessorCount)

include(ExternalProject)
include(GNUInstallDirs)

include(BuildPlatformDetection)
include(SetProjectDependencies)

ProcessorCount(N_PROC)
if(N_PROC EQUAL 0)
    set(N_PROC 1)
endif()

# Hard-code the CPython executable to use later because all find_package()
# commands are executed when the Makefiles are generated. Because we need to
# compile CPython first, all other projects that require Python must use our
# compiled one. Because we cannot use find_package() to find Python at runtime,
# we have to hard-code the CPython executable that will be created later. All
# projects that requires Python must use the variable Python3_EXECUTABLE so they
# will use the right CPython.
if(WIN32)
    # Minimalistic preinstalled Python on Windows:
    set(Python3_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python.exe)
else()
    # All other OSs like OSX
    set(Python3_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python3)
endif()

# Build projects step
add_custom_target(projects ALL COMMENT "Building Projects...")

# On Linux, make sure that we use "lib" for libraries and create a symlink "lib64" pointing to "lib".
if(Linux)
    message(STATUS "Prepare lib and lib64 on Linux...")
    execute_process(
        COMMAND mkdir -p "${CMAKE_INSTALL_PREFIX}/lib"
    )
    execute_process(
        COMMAND ln -s "lib" "lib64"
        WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}"
    )
endif()

if (APPLE)
    message(STATUS "Compiling against libc++")
    set(CMAKE_CXX_FLAGS ("-stdlib=libc++")
endif()

file(GLOB _projects projects/*.cmake)
foreach(_project ${_projects})
    include(${_project})
endforeach()

ProcessProjectDependencies(TARGET projects)
