if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(NumPy
        URL http://downloads.sourceforge.net/project/numpy/NumPy/1.11.1/numpy-1.11.1.tar.gz
        URL_MD5 2f44a895a8104ffac140c3a70edbd450
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET NumPy DEPENDS Python OpenBLAS)
else()
    ExternalProject_Add(NumPy
        GIT_REPOSITORY https://github.com/numpy/windows-wheel-builder
        GIT_TAG origin/master
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_SOURCE_DIR}/projects/build_numpy.bat ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/projects/numpy_distutils_gfortran.patch
        INSTALL_COMMAND cd numpy/dist && ${PYTHON_EXECUTABLE} -m pip install --force-reinstall --upgrade --pre --no-index -f . numpy
        BUILD_IN_SOURCE 1
    )
endif()
