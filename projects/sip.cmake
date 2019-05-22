if(BUILD_OS_WINDOWS)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
        --platform win32-msvc2015
    )
elseif(BUILD_OS_LINUX)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
    )
elseif(BUILD_OS_OSX)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
    )
else()
    set(sip_command "")
endif()

ExternalProject_Add(Sip
    URL http://downloads.sourceforge.net/project/pyqt/sip/sip-4.19.8/sip-4.19.8.zip
    URL_MD5 8ac2349d2d171f2661e208da7efbe627
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
