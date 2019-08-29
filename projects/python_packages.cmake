add_custom_target(NumpyScipyShapely ALL DEPENDS Python)

# Numpy, Scipy, Shapely
if(NOT BUILD_OS_WINDOWS)
    # On Mac, building with gfortran can be a problem. If we install scipy via pip, it will compile Fortran code
    # using gfortran by default, but if we install it manually, it will use f2py from numpy to convert Fortran
    # code to Python code and then compile, which solves this problem.
    # So, for non-Windows builds, we install scipy manually.

    # Numpy
    add_custom_target(Numpy ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install numpy==1.15.4
        DEPENDS Python
    )

    set(scipy_build_command ${Python3_EXECUTABLE} setup.py build)
    set(scipy_install_command ${Python3_EXECUTABLE} setup.py install)
    if(BUILD_OS_OSX)
        set(scipy_build_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_build_command})
        set(scipy_install_command env LDFLAGS="-undefined dynamic_lookup" ${scipy_install_command})
    endif()

    # Scipy
    ExternalProject_Add(Scipy
        URL https://github.com/scipy/scipy/releases/download/v1.2.0/scipy-1.2.0.tar.gz
        URL_MD5 e57011507865b0b702aff6077d412e03
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${scipy_build_command}
        INSTALL_COMMAND ${scipy_install_command}
        BUILD_IN_SOURCE 1
        DEPENDS Numpy
    )

    # Shapely
    add_custom_target(Shapely ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install "shapely[vectorized]==1.6.4.post2"
        DEPENDS Scipy
    )

    add_dependencies(NumpyScipyShapely Scipy)
else()
    ### MASSSIVE HACK TIME!!!!
    # It is currently effectively impossible to build SciPy on Windows without a proprietary compiler (ifort).
    # This means we need to use a pre-compiled binary version of Scipy. Since the only version of SciPy for
    # Windows available depends on numpy with MKL, we also need the binary package for that.
    if(BUILD_OS_WIN32)
        add_custom_command(TARGET NumpyScipyShapely PRE_BUILD
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.15.4+mkl-cp35-cp35m-win32.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-1.2.0-cp35-cp35m-win32.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely-1.6.4.post1-cp35-cp35m-win32.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
        )
    else()
        add_custom_command(TARGET NumpyScipyShapely PRE_BUILD
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.15.4+mkl-cp35-cp35m-win_amd64.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy-1.2.0-cp35-cp35m-win_amd64.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely-1.6.4.post1-cp35-cp35m-win_amd64.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
        )
    endif()
endif()

# Other Python Packages
add_custom_target(PythonPackages ALL
    COMMAND ${Python3_EXECUTABLE} -m pip install appdirs==1.4.3
    COMMAND ${Python3_EXECUTABLE} -m pip install certifi==2019.6.16
    COMMAND ${Python3_EXECUTABLE} -m pip install chardet==3.0.4
    COMMAND ${Python3_EXECUTABLE} -m pip install decorator==4.4.0
    COMMAND ${Python3_EXECUTABLE} -m pip install idna==2.8
    COMMAND ${Python3_EXECUTABLE} -m pip install netifaces==0.10.9
    COMMAND ${Python3_EXECUTABLE} -m pip install networkx==2.3
    COMMAND ${Python3_EXECUTABLE} -m pip install numpy-stl==2.10.1
    COMMAND ${Python3_EXECUTABLE} -m pip install packaging==19.1
    COMMAND ${Python3_EXECUTABLE} -m pip install pycollada==0.6
    COMMAND ${Python3_EXECUTABLE} -m pip install pycparser==2.19
    COMMAND ${Python3_EXECUTABLE} -m pip install pyparsing==2.4.2
    COMMAND ${Python3_EXECUTABLE} -m pip install pyserial==3.4
    COMMAND ${Python3_EXECUTABLE} -m pip install python-dateutil==2.8.0
    COMMAND ${Python3_EXECUTABLE} -m pip install python-utils==2.3.0
    COMMAND ${Python3_EXECUTABLE} -m pip install requests==2.22.0
    COMMAND ${Python3_EXECUTABLE} -m pip install six==1.12.0
    COMMAND ${Python3_EXECUTABLE} -m pip install trimesh==3.2.12
    COMMAND ${Python3_EXECUTABLE} -m pip install typing==3.7.4
    COMMAND ${Python3_EXECUTABLE} -m pip install urllib3==1.25.3
    COMMAND ${Python3_EXECUTABLE} -m pip install PyYAML==5.1.2
    COMMAND ${Python3_EXECUTABLE} -m pip install zeroconf==0.17.6
    COMMENT "Install Python packages"
    DEPENDS NumpyScipyShapely
)

# OS-specific Packages
if(BUILD_OS_WINDOWS)
    add_custom_command(TARGET PythonPackages POST_BUILD
        COMMAND ${Python3_EXECUTABLE} -m pip install comtypes==1.1.7
        COMMENT "Install comtypes"
    )
endif()
