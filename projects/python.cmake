if(APPLE)
    # See http://bugs.python.org/issue21381
    # The interpreter crashes when MACOSX_DEPLOYMENT_TARGET=10.7 due to the increased stack size.
    set(patch_command sed -i".bak" "9271,9271d" <SOURCE_DIR>/configure)
endif()

ExternalProject_Add(Python
    URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
    URL_MD5 3fe8434643a78630c61c6464fe2e7e72
    PATCH_COMMAND ${patch_command}
    CONFIGURE_COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --with-threads --without-pymalloc
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Python)
