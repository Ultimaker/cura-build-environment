project(cura-build-environment)

cmake_minimum_required(VERSION 3.2.0)

# This should care that our CMAKE_INSTALL_PREFIX is absolute at the end...
get_filename_component(CMAKE_INSTALL_PREFIX
                       ${CMAKE_INSTALL_PREFIX}
                       ABSOLUTE
                       CACHE FORCE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(ExternalProject)
include(GNUInstallDirs)

include(BuildPlatformDetection)
include(SetProjectDependencies)

# Preparing for building into a prefix
set(ENV{PATH} ${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} CACHE STRING "PATH" FORCE)
set(ENV{LD_LIBRARY_PATH} ${CMAKE_INSTALL_PREFIX}/lib/)
if($ENV{PYTHONPATH})
    set(ENV{PYTHONPATH} ${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages:$ENV{PYTHONPATH})
else()
    set(ENV{PYTHONPATH} ${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages)
endif()
set(PYTHON_EXECUTABLE_PREFIXED LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH} PATH=$ENV{PATH} PYTHONPATH=$ENV{PYTHONPATH} python3)

# Build projects step
add_custom_target(projects ALL COMMENT "Building Projects...")

file(GLOB _projects projects/*.cmake)
foreach(_project ${_projects})
    include(${_project})
endforeach()

ProcessProjectDependencies(TARGET projects)
