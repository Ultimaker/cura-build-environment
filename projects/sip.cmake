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
    URL_HASH SHA256=edcd3790bb01938191eef0f6117de0bf56d1136626c0ddb678f3a558d62e41e5
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
