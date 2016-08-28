
if(BUILD_OS_OSX)
    set(protobuf_cxx_flags "-fPIC -std=c++11 -stdlib=libc++")
else()
    set(protobuf_cxx_flags "-fPIC -std=c++11")
endif()

ExternalProject_Add(Protobuf
    URL https://github.com/google/protobuf/archive/v3.0.0-beta-4.tar.gz
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${protobuf_cxx_flags} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -G ${CMAKE_GENERATOR} ../Protobuf/cmake
)

ExternalProject_Add(Arcus
    GIT_REPOSITORY https://github.com/ultimaker/libArcus
    GIT_TAG origin/master
    CMAKE_COMMAND PATH=${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib/ PYTHONPATH=${CMAKE_INSTALL_PREFIX}/lib/python3:${CMAKE_INSTALL_PREFIX}/lib/python3.5  cmake
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DBUILD_EXAMPLES=OFF -DBUILD_STATIC=ON -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX} -G ${CMAKE_GENERATOR}
)

SetProjectDependencies(TARGET Arcus DEPENDS Sip Protobuf)
