if(BUILD_OS_OSX OR BUILD_OS_LINUX)
    get_property(MAIN_CXX_FLAGS GLOBAL PROPERTY COMPILE_OPTIONS)
    if(NOT MAIN_CXX_FLAGS)
        message(STATUS" No CXX_FLAGS set for zlib")
        set(MAIN_CXX_FLAGS )
    endif()
    ExternalProject_Add(zlib
        URL https://www.zlib.net/zlib-1.2.11.tar.gz
        URL_HASH SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1
        CONFIGURE_COMMAND CXX_FLAGS="${MAIN_CXX_FLAGS}"  CC="${CMAKE_C_COMPILER}"  CXX="${CMAKE_CXX_COMPILER}" ./configure --64 --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND make -j ${N_PROC}
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()
