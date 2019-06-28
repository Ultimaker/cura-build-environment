set(_cura_protobuf_url https://github.com/google/protobuf/archive/v3.0.2.tar.gz)
set(_cura_protobuf_md5 7349a7f43433d72c6d805c6ca22b7eeb)

if(BUILD_OS_OSX)
    set(protobuf_cxx_flags "-fPIC -std=c++11 -stdlib=libc++")
elseif(BUILD_OS_LINUX)
    set(protobuf_cxx_flags "-fPIC -std=c++11")
else()
    set(protobuf_cxx_flags "")
endif()

set(protobuf_configure_args
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_INSTALL_CMAKEDIR=lib/cmake/protobuf
    -DCMAKE_CXX_FLAGS=${protobuf_cxx_flags}
    -Dprotobuf_BUILD_TESTS=OFF
    -Dprotobuf_BUILD_EXAMPLES=OFF
    -Dprotobuf_BUILD_SHARED_LIBS=OFF
    -Dprotobuf_WITH_ZLIB=OFF
)

if(BUILD_OS_OSX)
    if (CMAKE_OSX_DEPLOYMENT_TARGET)
        list(APPEND protobuf_configure_args
            -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
        )
    endif()
    if (CMAKE_OSX_SYSROOT)
        list(APPEND protobuf_configure_args
            -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
        )
    endif()
endif()

ExternalProject_Add(Protobuf
    URL     ${_cura_protobuf_url}
    URL_MD5 ${_cura_protobuf_md5}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} ${protobuf_configure_args} -G ${CMAKE_GENERATOR} ../Protobuf/cmake
)

if(BUILD_OS_WINDOWS)
    # Compile it again, this time using MinGW
    # We need to build the Arcus Python plugin with MSVC due to Python.
    # However, we also need a MinGW library because CuraEngine does not really support MSVC.
    # Since the two are ABI-incompatible we need two versions of the library...
    set(protobuf_configure_args
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_INSTALL_LIBDIR=lib-mingw
        -DCMAKE_CXX_STANDARD=11
        -DCMAKE_CXX_STANDARD_REQUIRED=ON
        -DCMAKE_CXX_EXTENSIONS=OFF
        -Dprotobuf_BUILD_TESTS=OFF
        -Dprotobuf_BUILD_EXAMPLES=OFF
        -Dprotobuf_BUILD_SHARED_LIBS=OFF
        -Dprotobuf_WITH_ZLIB=OFF
    )

    # HACK: Protobuf-MinGW depends on Protobuf is because CuraEngine needs to use protoc.exe to generate C++ code.
    # Because we compile CuraEngine with MinGW, it needs to use the protoc.exe that's also compiled with MinGW to
    # generate C++ code and library links that works with MinGW. With the current configuration, because Protobuf-MinGW
    # depends on Protobuf, it will install its binary into CMAKE_INSTALL_PREFIX\bin, overwriting the protoc.exe
    # compiled with MSVC. Because we don't need the protoc.exe from MSVC, this works. Ideally, it would be better to
    # separate the 2 sub-environments, MSVC and MinGW, but to keep this compatible with the current systems, we leave
    # it for now.
    ExternalProject_Add(Protobuf-MinGW
        URL     ${_cura_protobuf_url}
        URL_MD5 ${_cura_protobuf_md5}
        DEPENDS Protobuf
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${protobuf_configure_args} -G "MinGW Makefiles" ../Protobuf-MinGW/cmake
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )
endif()
