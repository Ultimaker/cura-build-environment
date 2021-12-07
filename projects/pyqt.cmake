set(pyqt_command "")
if(NOT BUILD_OS_WINDOWS)
    # Building PyQt on Windows is problematic due to linking against specific Windows libraries.
    # Instead, we'll use the less favourable approach of installation via Pip, which drags PyPI into the circle of trust.
    # See requirements.txt for installing on windows with pip
    # TODO: PyPi is already in out circle of trust why not use the same approach for the Linux and MacOS
    if(BUILD_OS_OSX)
        set(pyqt_command
            ${Python3_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )
    else()
        set(pyqt_command
            # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
            "LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${Python3_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )
    endif()

    ExternalProject_Add(PyQt
        URL https://files.pythonhosted.org/packages/28/6c/640e3f5c734c296a7193079a86842a789edb7988dca39eab44579088a1d1/PyQt5-5.15.2.tar.gz
        URL_HASH SHA256=372b08dc9321d1201e4690182697c5e7ffb2e0770e6b4a45519025134b12e4fc
        CONFIGURE_COMMAND ${pyqt_command}
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)

endif()
