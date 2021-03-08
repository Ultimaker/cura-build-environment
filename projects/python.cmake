set(python_patch_command "")
set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --enable-ipv6 --with-threads --without-pymalloc )
set(python_build_command make)
set(python_install_command make install)

if(BUILD_OS_OSX)
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

    # Use the Windows Batch script to pass an argument "/p:PlatformToolset=v140". The argument must have double quotes
    # around it, otherwise it will be evaluated as "/p:PlatformToolset v140" in Windows Batch. Passing this argument
    # in CMake via a command seems to always result in "/p:PlatformToolset v140".
    if(BUILD_OS_WIN32)
        set(python_build_command cmd /c "${CMAKE_SOURCE_DIR}/projects/build_python_windows.bat" "<SOURCE_DIR>/PCbuild/build.bat" --no-tkinter -c Release -e -M -p Win32)
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat win32 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    else()
        set(python_build_command cmd /c "${CMAKE_SOURCE_DIR}/projects/build_python_windows.bat" "<SOURCE_DIR>/PCbuild/build.bat" --no-tkinter -c Release -e -M -p x64)
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat amd64 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    endif()
endif()

ExternalProject_Add(Python
    URL https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
    URL_HASH SHA256=7899e8a6f7946748830d66739f2d8f2b30214dad956e56b9ba216b3de5581519
    PATCH_COMMAND ${python_patch_command}
    CONFIGURE_COMMAND "${python_configure_command}"
    BUILD_COMMAND ${python_build_command}
    INSTALL_COMMAND ${python_install_command}
    BUILD_IN_SOURCE 1
)

# Only build geos on Linux
# cryptography requires cffi, which requires libffi
if(BUILD_OS_LINUX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS Geos OpenSSL bzip2-static bzip2-shared xz zlib sqlite3 libffi)
elseif(BUILD_OS_OSX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS Geos OpenSSL xz zlib sqlite3 libffi)
else()
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS)
endif()

# Make sure pip and setuptools are installed into our new Python
ExternalProject_Add_Step(Python ensurepip
    COMMAND ${Python3_EXECUTABLE} -m ensurepip
    DEPENDEES install
)

ExternalProject_Add_Step(Python upgrade_packages
    COMMAND ${Python3_EXECUTABLE} -m pip install pip==19.3.1
    COMMAND ${Python3_EXECUTABLE} -m pip install setuptools==41.4.0
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest==5.2.1
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest-benchmark==3.2.2
    COMMAND ${Python3_EXECUTABLE} -m pip install pytest-cov==2.8.1
    COMMAND ${Python3_EXECUTABLE} -m pip install mypy==0.740
    DEPENDEES ensurepip
)
