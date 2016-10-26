if(BUILD_OS_OSX)
    set(protobuf_cxx_flags "-fPIC -std=c++11 -stdlib=libc++")
else()
    set(protobuf_cxx_flags "-fPIC -std=c++11")
endif()

ExternalProject_Add(Protobuf
    URL https://github.com/google/protobuf/archive/v3.0.2.tar.gz
    URL_MD5 845b39e4b7681a2ddfd8c7f528299fbb
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${protobuf_cxx_flags} -Dprotobuf_BUILD_SHARED_LIBS=OFF -Dprotobuf_WITH_ZLIB=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -G ${CMAKE_GENERATOR} ../Protobuf/cmake
)
SetProjectDependencies(TARGET Protobuf)
