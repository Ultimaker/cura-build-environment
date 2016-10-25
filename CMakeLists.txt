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

# For all OSs:
if($ENV{PYTHONPATH})
        set(ENV{PYTHONPATH} ${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages:$ENV{PYTHONPATH})
    else()
        set(ENV{PYTHONPATH} ${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages)
    endif()

# OS-specific changes
if(BUILD_OS_LINUX)
    # Preparing for building into a prefix on Linux
    set(ENV{PATH} ${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} CACHE STRING "PATH" FORCE)
    set(ENV{LD_LIBRARY_PATH} ${CMAKE_INSTALL_PREFIX}/lib/)
    set(PYTHON_EXECUTABLE python3)
    set(PYTHON_EXECUTABLE_PREFIXED LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH} PATH=$ENV{PATH} PYTHONPATH=$ENV{PYTHONPATH} ${PYTHON_EXECUTABLE})
elseif(BUILD_OS_WINDOWS)
    # Minimalistic preinstalled Python on Windows:
    set(PYTHON_EXECUTABLE python)
    set(PYTHON_EXECUTABLE_PREFIXED ${PYTHON_EXECUTABLE})
else()
    # All other OSs like OSX
    set(PYTHON_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/python3)
    set(PYTHON_EXECUTABLE_PREFIXED PYTHONPATH=$ENV{PYTHONPATH} ${PYTHON_EXECUTABLE})
endif()

# Build projects step
add_custom_target(projects ALL COMMENT "Building Projects...")

file(GLOB _projects projects/*.cmake)
foreach(_project ${_projects})
    include(${_project})
endforeach()

ProcessProjectDependencies(TARGET projects)
