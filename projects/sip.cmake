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
    URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz
    URL_MD5 595e9ad6bb0a4b3a6ea92c163a05d19c
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
