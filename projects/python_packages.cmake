add_custom_target(NumpyScipyShapely ALL DEPENDS Python)

# Numpy, Scipy, Shapely
if(NOT BUILD_OS_WINDOWS)
    # On macOS (Catalina), building from source can be a problem, because scipy is compiled using the cmath files 
    # within the XCode CommandLineTools /usr/include directory, which are apparently missing some functions.
    # Thus, for macOS we install scipy via pip on Catalina.
    # On Linux we continue installing scipy manually from source.

    # Numpy
    add_custom_target(Numpy ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install numpy==1.20.2
        DEPENDS Python
    )

    if(BUILD_OS_OSX)
        # Scipy on macOS
        add_custom_target(Scipy ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install scipy==1.6.2
        DEPENDS Numpy
    )
    else()
    # Scipy on Linux
    set(scipy_build_command ${Python3_EXECUTABLE} setup.py build)
    set(scipy_install_command ${Python3_EXECUTABLE} setup.py install)
    ExternalProject_Add(Scipy
        GIT_REPOSITORY https://github.com/scipy/scipy.git
        GIT_TAG v1.6.1
        GIT_SHALLOW TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${scipy_build_command}
        INSTALL_COMMAND ${scipy_install_command}
        BUILD_IN_SOURCE 1
        DEPENDS Numpy
    )
    endif()

    # Shapely
    add_custom_target(Shapely ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install "shapely[vectorized]==1.7.1"
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
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/numpy-1.20.2+mkl-cp38-cp38-win32.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/scipy-1.6.3-cp38-cp38-win32.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/Shapely-1.7.1-cp38-cp38-win32.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
        )
    else()
        add_custom_command(TARGET NumpyScipyShapely PRE_BUILD
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/numpy-1.20.2+mkl-cp38-cp38-win_amd64.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/scipy-1.6.3-cp38-cp38-win_amd64.whl
            COMMAND ${Python3_EXECUTABLE} -m pip install https://software.ultimaker.com/cura-binary-dependencies/Shapely-1.7.1-cp38-cp38-win_amd64.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
        )
    endif()
    # An additional hack, as the DLLs are correctly generated, but not where subsequent machinations expect them:
    # (They're kind of massive, so move instead of copy.)
    file(TO_NATIVE_PATH "${CMAKE_INSTALL_PREFIX}/lib/site-packages/numpy/DLLs/*.dll" _NUMPY_DLLS_SRC)
    file(TO_NATIVE_PATH "${CMAKE_INSTALL_PREFIX}/lib/site-packages/numpy/core/." _NUMPY_DLLS_DST)
    add_custom_command(TARGET NumpyScipyShapely POST_BUILD
        COMMAND move ${_NUMPY_DLLS_SRC} ${_NUMPY_DLLS_DST}
        COMMENT "Move Numpy et-al DLLs to the expected location"
    )
endif()

# Other Python Packages
add_custom_target(PythonPackages ALL
    COMMAND ${Python3_EXECUTABLE} -m pip install appdirs==1.4.3
    COMMAND ${Python3_EXECUTABLE} -m pip install certifi==2019.11.28
    COMMAND ${Python3_EXECUTABLE} -m pip install cffi==1.14.1
    COMMAND ${Python3_EXECUTABLE} -m pip install chardet==3.0.4
    COMMAND ${Python3_EXECUTABLE} -m pip install cryptography==3.4.6
    COMMAND ${Python3_EXECUTABLE} -m pip install decorator==4.4.0
    COMMAND ${Python3_EXECUTABLE} -m pip install idna==2.8
    COMMAND ${Python3_EXECUTABLE} -m pip install importlib-metadata==3.7.2  # Dependency of cx_Freeze
    COMMAND ${Python3_EXECUTABLE} -m pip install netifaces==0.10.9
    COMMAND ${Python3_EXECUTABLE} -m pip install networkx==2.3
    COMMAND ${Python3_EXECUTABLE} -m pip install numpy-stl==2.10.1
    COMMAND ${Python3_EXECUTABLE} -m pip install packaging==18.0
    COMMAND ${Python3_EXECUTABLE} -m pip install pycollada==0.6
    COMMAND ${Python3_EXECUTABLE} -m pip install pycparser==2.19
    COMMAND ${Python3_EXECUTABLE} -m pip install pyparsing==2.4.2
    COMMAND ${Python3_EXECUTABLE} -m pip install PyQt5-sip==12.8.1
    COMMAND ${Python3_EXECUTABLE} -m pip install pyserial==3.4
    COMMAND ${Python3_EXECUTABLE} -m pip install python-dateutil==2.8.0
    COMMAND ${Python3_EXECUTABLE} -m pip install python-utils==2.3.0
    COMMAND ${Python3_EXECUTABLE} -m pip install requests==2.22.0
    COMMAND ${Python3_EXECUTABLE} -m pip install sentry-sdk==0.13.5
    COMMAND ${Python3_EXECUTABLE} -m pip install six==1.12.0
    # https://github.com/mikedh/trimesh/issues/575 since 3.2.34
    COMMAND ${Python3_EXECUTABLE} -m pip install trimesh==3.2.33
    # For testing HTTP requests
    COMMAND ${Python3_EXECUTABLE} -m pip install twisted==21.2.0
    COMMAND ${Python3_EXECUTABLE} -m pip install urllib3==1.25.6
    COMMAND ${Python3_EXECUTABLE} -m pip install zeroconf==0.31.0
    # For handling cached authentication values when doing backups and the like:
    COMMAND ${Python3_EXECUTABLE} -m pip install keyring==23.0.1

    COMMENT "Install Python packages"
    DEPENDS NumpyScipyShapely
)

# OS-specific Packages
if(BUILD_OS_WINDOWS)
    add_custom_command(TARGET PythonPackages POST_BUILD
        COMMAND ${Python3_EXECUTABLE} -m pip install comtypes==1.1.7
        # pywin32 is required to provide the keyring library with access to the Windows Credential Manager
        COMMAND ${Python3_EXECUTABLE} -m pip install pywin32==300
        COMMENT "Install Windows-specific py-packages: comtypes, pywin32"
    )
endif()
