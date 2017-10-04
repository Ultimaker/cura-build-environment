if(BUILD_OS_OSX)
    set(protobuf_cxx_flags "-fPIC -std=c++11 -stdlib=libc++")
elseif(BUILD_OS_LINUX)
    set(protobuf_cxx_flags "-fPIC -std=c++11")
else()
    set(protobuf_cxx_flags "")
endif()

ExternalProject_Add(Protobuf
    URL https://github.com/google/protobuf/archive/v3.0.2.tar.gz
    URL_MD5 7349a7f43433d72c6d805c6ca22b7eeb
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_CMAKEDIR=lib/cmake/protobuf -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${protobuf_cxx_flags} -Dprotobuf_BUILD_SHARED_LIBS=OFF -Dprotobuf_WITH_ZLIB=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -G ${CMAKE_GENERATOR} ../Protobuf/cmake
)

if(BUILD_OS_WINDOWS)
    # Compile it again, this time using MinGW
    # We need to build the Arcus Python plugin with MSVC due to Python.
    # However, we also need a MinGW library because CuraEngine does not really support MSVC.
    # Since the two are ABI-incompatible we need two versions of the library...
    ExternalProject_Add(Protobuf-MinGW
        URL https://github.com/google/protobuf/archive/v3.0.2.tar.gz
        URL_MD5 7349a7f43433d72c6d805c6ca22b7eeb
        DEPENDS Protobuf
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib-mingw -DCMAKE_INSTALL_BINDIR=lib-mingw -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS="--std=c++11" -Dprotobuf_BUILD_SHARED_LIBS=OFF -Dprotobuf_WITH_ZLIB=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -G "MinGW Makefiles" ../Protobuf-MinGW/cmake
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )
endif()
