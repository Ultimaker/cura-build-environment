set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --with-threads --without-pymalloc)
#set(python_cmake_COMMAND cmake)
#set(python_cmake_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_BUILD_TYPE=Release -DPYTHON_VERSION=3.5.2 -DINSTALL_TEST=OFF -DBUILD_SHARED=ON)

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
    ## CMAKE_* can't be used here. The cmake command above always passes the generator here. Therefore CMake will always use MinGW on Windows for Python.
    # Needed for Python 3.5.x on Windows:
    #set(python_cmake_ARGS ${python_cmake_ARGS} -G "Visual Studio 14 2015")
    # Linker errors on Windows: https://github.com/python-cmake-buildsystem/python-cmake-buildsystem/issues/170
    #ExternalProject_Add(Python
    #    GIT_REPOSITORY https://github.com/python-cmake-buildsystem/python-cmake-buildsystem.git
    #    GIT_TAG origin/master
    #    CONFIGURE_COMMAND ${python_cmake_COMMAND} ${python_cmake_ARGS} ${CMAKE_BINARY_DIR}/Python-prefix/src/Python
    #    BUILD_COMMAND ""
    #    INSTALL_COMMAND ${python_cmake_COMMAND} --build . --target install
    #)

    #ExternalProject_Add(Python
    #    URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
    #    URL_MD5 3fe8434643a78630c61c6464fe2e7e72
    #    CONFIGURE_COMMAND ""
    #    BUILD_COMMAND PCBuild/build.bat -c Release -r -e --no-tkinter
    #    INSTALL_COMMAND ""
    #    BUILD_IN_SOURCE 1
    #)
    #add_custom_command(TARGET Python
    #                   POST_BUILD
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/Lib ${CMAKE_INSTALL_PREFIX}
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/py.exe ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/pyw.exe ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/python.exe ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/pythonw.exe ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/python3.dll ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/python35.dll ${CMAKE_INSTALL_PREFIX}/bin
    #                   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/Python-prefix/src/Python/PCbuild/win32/sqlite3.dll ${CMAKE_INSTALL_PREFIX}/DLLs
    #                   # [...]
    #)

    # Giving it up here.. Keeping the commented code here, just in case there will be further progress on one of the both solutions...
    add_custom_target(Python)

else()
    ExternalProject_Add(Python
        URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
        URL_MD5 3fe8434643a78630c61c6464fe2e7e72
        PATCH_COMMAND ${python_patch_command}
        CONFIGURE_COMMAND ${python_configure_command}
        BUILD_IN_SOURCE 1
    )
endif()