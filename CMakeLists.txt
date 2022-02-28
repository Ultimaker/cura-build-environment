#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

project(cura-build-environment)

cmake_minimum_required(VERSION 3.12)

if(NOT CURA_ARCUS_BRANCH_OR_TAG)
    set(CURA_ARCUS_BRANCH_OR_TAG "CURA-7924_sip_cmake_build")
endif()
if(NOT CURA_SAVITAR_BRANCH_OR_TAG)
    set(CURA_SAVITAR_BRANCH_OR_TAG "CURA-7924_sip_cmake_build")
endif()
if (NOT CURA_PYNEST2D_BRANCH_OR_TAG)
    set(CURA_PYNEST2D_BRANCH_OR_TAG "CURA-7924_sip_cmake_build")
endif()
# TODO: Revert this to the main branch for the top to when committing!
# TODO: Also, don't forget these when we switch to 'main' -> perhaps better to take the _current_ branch or tag even?

# This should care that our CMAKE_INSTALL_PREFIX is absolute at the end...
get_filename_component(CMAKE_INSTALL_PREFIX
                       ${CMAKE_INSTALL_PREFIX}
                       ABSOLUTE
                       CACHE FORCE)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

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
if(BUILD_OS_WINDOWS)
    # Minimalistic preinstalled Python on Windows:
    set(Python3_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python.exe)
else()
    # All other OSs like OSX
    set(Python3_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python3)
endif()

# Build projects step
add_custom_target(projects ALL COMMENT "Building Projects...")

# On Linux, make sure that we use "lib" for libraries and create a symlink "lib64" pointing to "lib".
if(BUILD_OS_LINUX)
    message(STATUS "Prepare lib and lib64 on Linux...")
    execute_process(
        COMMAND mkdir -p "${CMAKE_INSTALL_PREFIX}/lib"
    )
    execute_process(
        COMMAND ln -s "lib" "lib64"
        WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}"
    )
endif()

# Some extra post build additions are needed on macOS, as the eventual Cura build will fail, because otool
# throws an error while copying pyArcus.so to the Ultimaker Cura.app bundle.
if(BUILD_OS_OSX)
    add_custom_command(
        TARGET projects POST_BUILD
        COMMAND /Library/Developer/CommandLineTools/usr/bin/install_name_tool -change @rpath/libprotobuf.3.15.7.0.dylib "${CMAKE_INSTALL_PREFIX}/lib/libprotobuf.3.15.7.0.dylib" "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/pyArcus.so"
        COMMAND /Library/Developer/CommandLineTools/usr/bin/install_name_tool -change @rpath/libArcus.3.dylib "${CMAKE_INSTALL_PREFIX}/lib/libArcus.3.dylib" "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/pyArcus.so"
        COMMENT "Changing the RPATH of pyArcus"
    )
endif()

file(GLOB _projects projects/*.cmake)
foreach(_project ${_projects})
    include(${_project})
endforeach()

ProcessProjectDependencies(TARGET projects)
