# Copyright (c) 2022 Ultimaker B.V.
# cura-build-environment is released under the terms of the AGPLv3 or higher.

if(WIN32)
    ExternalProject_Add(pyinstaller_win
        URL https://github.com/pyinstaller/pyinstaller/archive/v4.10.tar.gz
        URL_HASH SHA256=bd388f25dbe1f13274240319638c1145935476701c453b89589b59cf3cb47895
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_COMMAND} -E chdir bootloader ${Python_VENV_EXECUTABLE} ./waf all
        INSTALL_COMMAND ${Python_VENV_EXECUTABLE} setup.py install
        BUILD_IN_SOURCE 1
    )
endif()
