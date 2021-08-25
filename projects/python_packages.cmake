add_custom_target(NumpyScipyShapely ALL DEPENDS Python)

# Numpy, Scipy, Shapely
if(NOT BUILD_OS_WINDOWS)
    # On macOS (Catalina), building from source can be a problem, because scipy is compiled using the cmath files 
    # within the XCode CommandLineTools /usr/include directory, which are apparently missing some functions.
    # Thus, for macOS we install scipy via pip on Catalina.
    # On Linux we continue installing scipy manually from source.

    # Numpy
    add_custom_target(Numpy ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r ../projects/requirements/requirements_numpy.txt
        DEPENDS Python
    )

    if(BUILD_OS_OSX)
        # Scipy on macOS
        add_custom_target(Scipy ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r ../projects/requirements/requirements_scipy.txt
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
        COMMAND ${Python3_EXECUTABLE} -m pip install install --require-hashes -r ../projects/requirements/requirements_shapely.txt
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
    # UPDATE: Now it seems they may be generated in the correct location again. Rather than removing this, the step has been made optional with an '... || exit(0)'.
    file(TO_NATIVE_PATH "${CMAKE_INSTALL_PREFIX}/lib/site-packages/numpy/DLLs/*.dll" _NUMPY_DLLS_SRC)
    file(TO_NATIVE_PATH "${CMAKE_INSTALL_PREFIX}/lib/site-packages/numpy/core/." _NUMPY_DLLS_DST)
    add_custom_command(TARGET NumpyScipyShapely POST_BUILD
        COMMAND move ${_NUMPY_DLLS_SRC} ${_NUMPY_DLLS_DST} || (exit 0)
        COMMENT "Move Numpy et-al DLLs to the expected location. (Will continue on error.)"
    )
endif()

# Other Python Packages
add_custom_target(PythonPackages ALL
    COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r ../projects/requirements/requirements_default.txt

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
