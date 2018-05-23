if(BUILD_OS_WINDOWS)
    ExternalProject_Add(PythonComtypes
        URL https://files.pythonhosted.org/packages/df/79/2d3681f9a61b3dd09eb7774c1948a91a8cafaac6092a30370977a713c667/comtypes-1.1.4.zip
        URL_HASH SHA256=3174c7fbd043d33dfbe65b7ce91b9fd755c65c5f40f15a7678d71d5e80cdb73b
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=comtypes-install.log
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET PythonComtypes DEPENDS Python)
endif()
