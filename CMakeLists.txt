project(cura-build-environment)

cmake_minimum_required(VERSION 3.6)

if(NOT CURA_ARCUS_BRANCH_OR_TAG)
    set(CURA_ARCUS_BRANCH_OR_TAG "master")
endif()
if(NOT CURA_SAVITAR_BRANCH_OR_TAG)
    set(CURA_SAVITAR_BRANCH_OR_TAG "master")
endif()

# This should care that our CMAKE_INSTALL_PREFIX is absolute at the end...
get_filename_component(CMAKE_INSTALL_PREFIX
                       ${CMAKE_INSTALL_PREFIX}
                       ABSOLUTE
                       CACHE FORCE)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)
include(GNUInstallDirs)

include(BuildPlatformDetection)
include(SetProjectDependencies)

option(INCLUDE_DEVEL "Include development tools" OFF)

# OS-specific changes
if(BUILD_OS_WINDOWS)
    # Minimalistic preinstalled Python on Windows:
    set(PYTHON_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python.exe)
else()
    # All other OSs like OSX
    set(PYTHON_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python3)
endif()

# Build projects step
add_custom_target(projects ALL COMMENT "Building Projects...")

file(GLOB _projects projects/*.cmake)
foreach(_project ${_projects})
    include(${_project})
endforeach()

if(INCLUDE_DEVEL)
    file(GLOB _devel_projects devel/*.cmake)
    foreach(_devel_project ${_devel_projects})
        include(${_devel_project})
    endforeach()
endif()

ProcessProjectDependencies(TARGET projects)
