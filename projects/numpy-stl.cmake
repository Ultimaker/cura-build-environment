# Using NumpySTL installed via pip on Windows
# Eg. "pip3 install numpy-stl"
# Other OSs will build it manually...
if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(NumpySTL
        URL https://github.com/WoLpH/numpy-stl/archive/v1.9.0.tar.gz
        URL_MD5 cda2531edecff4468a4bbe78c6a2833b
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install --single-version-externally-managed --record=numpystl-install.log
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET NumpySTL DEPENDS NumPy python-utils)
endif()