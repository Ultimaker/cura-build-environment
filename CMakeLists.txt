project(cura-build-environment NONE)

cmake_minimum_required(VERSION 3.2.0)

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

# OS-specific changes
if(BUILD_OS_WINDOWS)
    # Minimalistic preinstalled Python on Windows:
    find_package(PythonInterp)
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

ProcessProjectDependencies(TARGET projects)
