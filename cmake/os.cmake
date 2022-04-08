# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

if(WIN32)
    set(ext .pyd)
    set(env_path_sep ";")
    set(exe_ext ".exe")
    set(exe_path "Scripts")
    set(lib_path "Lib")
    set(python_lib_path "${lib_path}")
else()
    set(ext .so)
    set(env_path_sep ":")
    set(exe_ext "")
    set(exe_path "bin")
    set(lib_path "lib")
    set(python_lib_path "${lib_path}/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}")
endif()

set(PYTHONPATH ${CMAKE_INSTALL_PREFIX}/${python_lib_path}/site-packages)
set(Python_VENV_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/${exe_path}/python${exe_ext})
set(Python_SITELIB_LOCAL ${CMAKE_INSTALL_PREFIX}/${python_lib_path}/site-packages/)

if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()