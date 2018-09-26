set(python_patch_command "")
set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --with-threads --without-pymalloc)
set(python_build_command make)
set(python_install_command make install)

if(BUILD_OS_OSX)
    # See http://bugs.python.org/issue21381
    # The interpreter crashes when MACOSX_DEPLOYMENT_TARGET=10.7 due to the increased stack size.
    set(python_patch_command sed -i".bak" "9271,9271d" <SOURCE_DIR>/configure)
    # OS X 10.11 removed OpenSSL. Brew now refuses to link so we need to manually tell Python's build system
    # to use the right linker flags.
    set(python_configure_command CPPFLAGS=-I/usr/local/opt/openssl/include LDFLAGS=-L/usr/local/opt/openssl/lib ${python_configure_command})
endif()

if(BUILD_OS_LINUX)
    # Set a proper RPATH so everything depending on Python does not need LD_LIBRARY_PATH
    set(python_configure_command LDFLAGS=-Wl,-rpath=${CMAKE_INSTALL_PREFIX}/lib ${python_configure_command})
endif()

if(BUILD_OS_WINDOWS)
    # Otherwise Python will not be able to get external dependencies.
    find_package(Subversion REQUIRED)
    
    set(python_configure_command )

    if(BUILD_OS_WIN32)
        set(python_build_command cmd /c "<SOURCE_DIR>/PCbuild/build.bat --no-tkinter -c Release -e -M -p Win32")
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat win32 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    else()
    set(python_build_command cmd /c "<SOURCE_DIR>/PCbuild/build.bat --no-tkinter -c Release -e -M -p x64")
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat amd64 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    endif()
endif()

ExternalProject_Add(Python
    URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
    URL_MD5 3fe8434643a78630c61c6464fe2e7e72
    PATCH_COMMAND ${python_patch_command}
    CONFIGURE_COMMAND "${python_configure_command}"
    BUILD_COMMAND ${python_build_command}
    INSTALL_COMMAND ${python_install_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Python DEPENDS OpenBLAS Geos)

# Make sure pip and setuptools are installed into our new Python
ExternalProject_Add_Step(Python ensurepip
    COMMAND ${PYTHON_EXECUTABLE} -m ensurepip
    DEPENDEES install
)

ExternalProject_Add_Step(Python upgrade_packages
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pip==18.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install setuptools==40.2.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pytest==3.8.1
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pytest-cov==2.6.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install mypy==0.630
    DEPENDEES ensurepip
)

# Numpy, Scipy, Shapely
if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add_Step(Python add_numpy_scipy_shapely
        COMMAND ${PYTHON_EXECUTABLE} -m pip install numpy==1.15.2
        COMMAND ${PYTHON_EXECUTABLE} -m pip install scipy==1.1.0
        COMMAND ${PYTHON_EXECUTABLE} -m pip install "shapely[vectorized]==1.6.4.post2"
        DEPENDEES upgrade_packages
    )
else()
    ### MASSSIVE HACK TIME!!!!
    # It is currently effectively impossible to build SciPy on Windows without a proprietary compiler (ifort).
    # This means we need to use a pre-compiled binary version of Scipy. Since the only version of SciPy for
    # Windows available depends on numpy with MKL, we also need the binary package for that.
    if(BUILD_OS_WIN32)
        ExternalProject_Add_Step(Python add_numpy_scipy_shapely
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.15.2+mkl-cp35-cp35m-win32.whl
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy‑1.1.0‑cp35‑cp35m‑win32.whl
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely‑1.6.4.post1‑cp35‑cp35m‑win32.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
            DEPENDEES upgrade_packages
        )
    else()
        ExternalProject_Add_Step(Python add_numpy_scipy_shapely
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/numpy-1.15.2+mkl-cp35-cp35m-win_amd64.whl
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/scipy‑1.1.0‑cp35‑cp35m‑win_amd64.whl
            COMMAND ${PYTHON_EXECUTABLE} -m pip install http://software.ultimaker.com/cura-binary-dependencies/Shapely‑1.6.4.post1‑cp35‑cp35m‑win_amd64.whl
            COMMENT "Install Numpy, Scipy, and Shapely"
            DEPENDEES upgrade_packages
        )
    endif()
endif()

# Other Python Packages
ExternalProject_Add_Step(Python add_other_python_packages
    COMMAND ${PYTHON_EXECUTABLE} -m pip install certifi==2018.8.24
    COMMAND ${PYTHON_EXECUTABLE} -m pip install chardet==3.0.4
    COMMAND ${PYTHON_EXECUTABLE} -m pip install decorator==4.3.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install idna==2.7
    COMMAND ${PYTHON_EXECUTABLE} -m pip install netifaces==0.10.7
    COMMAND ${PYTHON_EXECUTABLE} -m pip install networkx==2.2
    COMMAND ${PYTHON_EXECUTABLE} -m pip install numpy-stl==2.7.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install packaging==17.1
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pycparser==2.19
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pyparsing==2.2.1
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pyserial==3.4
    COMMAND ${PYTHON_EXECUTABLE} -m pip install python-utils==2.3.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install requests==2.19.1
    COMMAND ${PYTHON_EXECUTABLE} -m pip install six==1.11.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install trimesh==2.33.39
    COMMAND ${PYTHON_EXECUTABLE} -m pip install typing==3.6.6
    COMMAND ${PYTHON_EXECUTABLE} -m pip install urllib3==1.23
    COMMAND ${PYTHON_EXECUTABLE} -m pip install zeroconf==0.19.1
    DEPENDEES add_numpy_scipy_shapely
)

# OS-specific Packages
if(BUILD_OS_WINDOWS)
    ExternalProject_Add_Step(Python os_specific_packages
        COMMAND ${PYTHON_EXECUTABLE} -m pip install comtypes==1.1.7
        DEPENDEES add_other_python_packages
    )
endif()
