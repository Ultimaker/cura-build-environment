if(BUILD_OS_WINDOWS)
    ExternalProject_Add(PythonWin32
        URL https://netix.dl.sourceforge.net/project/pywin32/pywin32/Build%20221/pywin32-221.zip
        URL_MD5 bdb717442dee80081e6687057be86c05
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup3.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup3.py install --record=pywin32-install.log
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET PythonWin32 DEPENDS Python)
endif()
