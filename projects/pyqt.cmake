set(pyqt_command "")
if(BUILD_OS_WINDOWS)
    set(pyqt_command
        ${PYTHON_EXECUTABLE_PREFIXED} configure.py
        --sip ${CMAKE_INSTALL_PREFIX}/bin/sip.exe
        --confirm-license
        --spec win32-g++
        --destdir ${CMAKE_INSTALL_PREFIX}/lib/python3.4/site-packages
        --bindir ${CMAKE_INSTALL_PREFIX}/bin
        --sipdir ${CMAKE_INSTALL_PREFIX}/share/sip
        "CFLAGS+=${CMAKE_C_FLAGS}"
        "CXXFLAGS+=${CMAKE_CXX_FLAGS}"
    )
# HAS THIS BEEN REMOVED BEFORE?
#elseif(BUILD_OS_LINUX)
#    set(pyqt_command
#        ${PYTHON_EXECUTABLE_PREFIXED} configure.py
#        --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
#        --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
#        --confirm-license
#        --destdir ${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages
#        --bindir ${CMAKE_INSTALL_PREFIX}/bin
#        --sipdir ${CMAKE_INSTALL_PREFIX}/share/sip
#    )
else()
    set(pyqt_command
        ${PYTHON_EXECUTABLE_PREFIXED} configure.py
        --sysroot ${CMAKE_INSTALL_PREFIX}
        --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
        --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
        --confirm-license
    )
endif()

# Using PyQt installed via pip on Windows
# Eg. "pip3 install PyQt"
# Other OSs will build it manually...
if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(PyQt
        URL http://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.6/PyQt5_gpl-5.6.tar.gz
        URL_MD5 dbfc885c0548e024ba5260c4f44e0481
        CONFIGURE_COMMAND ${pyqt_command}
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)
endif()
