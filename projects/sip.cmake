if(BUILD_OS_WINDOWS)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --platform win32-msvc2015
    )
elseif(BUILD_OS_LINUX)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --bindir=${CMAKE_INSTALL_PREFIX}/bin
        --destdir=${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages
        --incdir=${CMAKE_INSTALL_PREFIX}/include
        --sipdir=${CMAKE_INSTALL_PREFIX}/share/sip
    )
elseif(BUILD_OS_OSX)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --sysroot=${CMAKE_INSTALL_PREFIX}
    )
else()
    set(sip_command "")
endif()

ExternalProject_Add(Sip
    URL http://downloads.sourceforge.net/project/pyqt/sip/sip-4.19.1/sip-4.19.1.zip
    URL_MD5 6ea2a6bf8e0790de1cebc1dd68a5a4bb
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
