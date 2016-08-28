set(sip_command "")
if(BUILD_OS_WINDOWS)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --platform win32-g++
        --bindir=${CMAKE_INSTALL_PREFIX}/bin
        --destdir=${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages
        --incdir=${CMAKE_INSTALL_PREFIX}/include
        --sipdir=${CMAKE_INSTALL_PREFIX}/share/sip
        "CFLAGS+=${CMAKE_C_FLAGS}"
        "CXXFLAGS+=${CMAKE_CXX_FLAGS}"
    )
elseif(BUILD_OS_LINUX)
    set(sip_command
        ${PYTHON_EXECUTABLE}
        configure.py
        --bindir=${CMAKE_INSTALL_PREFIX}/bin
        --destdir=${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages
        --incdir=${CMAKE_INSTALL_PREFIX}/include
        --sipdir=${CMAKE_INSTALL_PREFIX}/share/sip
    )
elseif(BUILD_OS_OSX)
    set(sip_command ${PYTHON_EXECUTABLE} configure.py --sysroot=${CMAKE_INSTALL_PREFIX})
endif()

ExternalProject_Add(Sip
    URL http://downloads.sourceforge.net/project/pyqt/sip/sip-4.18/sip-4.18.zip
    URL_MD5 e860d06782962fa02f81aeecba3d82a7
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
