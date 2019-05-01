set(python_patch_command "")
set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --with-threads --without-pymalloc)
set(python_build_command make)
set(python_install_command make install)

if(BUILD_OS_OSX)
    # See http://bugs.python.org/issue21381
    # The interpreter crashes when MACOSX_DEPLOYMENT_TARGET=10.7 due to the increased stack size.
    set(python_patch_command sed -i".bak" "9271,9271d" <SOURCE_DIR>/configure)
    if(CMAKE_OSX_SYSROOT)
        set(python_configure_command ${python_configure_command} --enable-universalsdk=${CMAKE_OSX_SYSROOT})
    else()
        set(python_configure_command ${python_configure_command} --enable-universalsdk)
    endif()
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

# Only build geos on Linux
if(BUILD_OS_LINUX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS Geos OpenSSL xz zlib sqlite3)
elseif(BUILD_OS_OSX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS Geos OpenSSL xz zlib sqlite3)
else()
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS)
endif()

# Make sure pip and setuptools are installed into our new Python
ExternalProject_Add_Step(Python ensurepip
    COMMAND ${Python3_EXECUTABLE} -m ensurepip
    DEPENDEES install
)

ExternalProject_Add_Step(Python upgrade_packages
    COMMAND ${Python3_EXECUTABLE} -m pip install pip==19.1
    COMMAND ${Python3_EXECUTABLE} -m pip install setuptools==41.0.1
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest==4.4.1
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest-benchmark==3.2.2
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest-cov==2.6.1
    COMMAND ${Python3_EXECUTABLE} -m pip install mypy==0.701
    DEPENDEES ensurepip
)
