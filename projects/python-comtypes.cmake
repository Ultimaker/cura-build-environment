if(BUILD_OS_WINDOWS)
    ExternalProject_Add(PythonComtypes
        URL https://pypi.python.org/packages/85/11/722b9ce6725bf8160bd8aca68b1e61bd9db422ab12dae28daa7defab2cdc/comtypes-1.1.3-2.zip
        URL_MD5 4161cb8bc283a75af85e220ad662d5af
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=comtypes-install.log
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET PythonComtypes DEPENDS Python)
endif()
