set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --enable-ipv6 --without-pymalloc )
set(python_build_command make -j ${N_PROC})
set(python_install_command make install)
set(patch_command )

if(BUILD_OS_WINDOWS)
    # Otherwise Python will not be able to get external dependencies.
    find_package(Subversion REQUIRED)

    set(python_configure_command )

    # Use the Windows Batch script to pass an argument "/p:PlatformToolset=v140". The argument must have double quotes
    # around it, otherwise it will be evaluated as "/p:PlatformToolset v140" in Windows Batch. Passing this argument
    # in CMake via a command seems to always result in "/p:PlatformToolset v140".
    set(python_build_command cmd /c "${CMAKE_SOURCE_DIR}/projects/build_python_windows.bat" "<SOURCE_DIR>/PCbuild/build.bat" --no-tkinter -c Release -e -M -p x64)
    set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat amd64 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
endif()

if(BUILD_OS_OSX)
    set(python_configure_command ${python_configure_command} --with-openssl=${CMAKE_INSTALL_PREFIX})
endif()

if(BUILD_OS_LINUX)
    # Set a proper RPATH so everything depending on Python does not need LD_LIBRARY_PATH
    set(python_configure_command LDFLAGS=-Wl,-rpath=${CMAKE_INSTALL_PREFIX}/lib ${python_configure_command} --with-openssl=${CMAKE_INSTALL_PREFIX})

    # FIXME: Not longer needed when we update to Python 3.11
    set(patch_command git apply ${CMAKE_SOURCE_DIR}/projects/0001-bpo-45433-Do-not-link-libpython-against-libcrypt-GH-.patch)
endif()

ExternalProject_Add(Python
    GIT_REPOSITORY https://github.com/python/cpython.git
    GIT_TAG v3.10.2
    PATCH_COMMAND ${patch_command}
    CONFIGURE_COMMAND "${python_configure_command}"
    BUILD_COMMAND ${python_build_command}
    INSTALL_COMMAND ${python_install_command}
    BUILD_IN_SOURCE 1
)

# CPython has a number of dependencies (OpenSSL, bzip, xz, zlib, sqlite)
# cryptography requires cffi, which requires libffi
# Numpy needs OpenBLAS.
if(BUILD_OS_LINUX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS OpenSSL bzip2-static bzip2-shared xz zlib sqlite3 libffi)
elseif(BUILD_OS_OSX)
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS OpenSSL xz zlib sqlite3 libffi)
else()
    SetProjectDependencies(TARGET Python DEPENDS OpenBLAS)
endif()

# Make sure pip and setuptools are installed into our new Python
ExternalProject_Add_Step(Python ensurepip
    COMMAND ${Python3_EXECUTABLE} -m ensurepip
    DEPENDEES install
)

ExternalProject_Add_Step(Python baserequirements
    COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r ${CMAKE_SOURCE_DIR}/projects/base_requirements.txt
    DEPENDEES ensurepip
)
