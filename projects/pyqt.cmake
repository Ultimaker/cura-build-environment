set(pyqt_command "")
if(BUILD_OS_WINDOWS)
    add_custom_target(PyQt
        COMMAND ${PYTHON_EXECUTABLE} -m pip install PyQt5==5.8.2
        COMMENT "Installing PyQt5"
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Python)
else()
    set(pyqt_command
        # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
        "LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
        ${PYTHON_EXECUTABLE} configure.py
        --sysroot ${CMAKE_INSTALL_PREFIX}
        --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
        --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
        --confirm-license
    )

    ExternalProject_Add(PyQt
        URL https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.8.2/PyQt5_gpl-5.8.2.tar.gz
        URL_MD5 c3048e9d242f3e72fd393630da1d971a
        CONFIGURE_COMMAND ${pyqt_command}
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)

endif()
