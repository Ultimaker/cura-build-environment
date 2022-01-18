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
    URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.25/sip-4.19.25.tar.gz
    URL_HASH SHA256=b39d93e937647807bac23579edbff25fe46d16213f708370072574ab1f1b4211
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
