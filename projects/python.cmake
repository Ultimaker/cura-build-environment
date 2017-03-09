set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --with-threads --without-pymalloc)

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
    # Build Python using the CMake build system and msbuild
    if(BUILD_OS_WIN64)
        set(_python_generator "Visual Studio 14 2015 Win64")
    else()
        set(_python_generator "Visual Studio 14 2015")
    endif()

    ExternalProject_Add(Python
        # Note: Using zip download to prevent CMake continuously rebuilding Python
        URL https://github.com/python-cmake-buildsystem/python-cmake-buildsystem/archive/9cce62ea7c31f8a4db912a034b345a8a3177a45f.zip
        CMAKE_GENERATOR ${_python_generator}
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DPYTHON_VERSION=3.5.2 -DINSTALL_TEST=OFF -DINSTALL_MANUAL=OFF -DBUILD_TESTING=OFF -DBUILD_LIBPYTHON_SHARED=ON -DIS_PY3=TRUE -DOPENSSL_ROOT_DIR=${CMAKE_INSTALL_PREFIX} -DCMAKE_SHARED_LINKER_FLAGS=/SAFESEH:NO
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config Release
        INSTALL_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --config Release --target INSTALL
    )

    ExternalProject_Add_Step(Python ensurepip
        COMMAND ${CMAKE_INSTALL_PREFIX}/bin/python -m ensurepip
        DEPENDEES install
    )

    SetProjectDependencies(TARGET Python DEPENDS OpenSSL)
else()
    ExternalProject_Add(Python
        URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
        URL_MD5 3fe8434643a78630c61c6464fe2e7e72
        PATCH_COMMAND ${python_patch_command}
        CONFIGURE_COMMAND ${python_configure_command}
        BUILD_IN_SOURCE 1
    )
endif()
