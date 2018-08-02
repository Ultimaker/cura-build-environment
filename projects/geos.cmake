if(BUILD_OS_LINUX)
    ExternalProject_Add(Geos
        URL https://github.com/libgeos/geos/archive/3.6.2.tar.gz
        URL_HASH SHA256=e9ac89baab59dbb585c38f8b8449627d53b57ae79100d8bbca836907c0b6c27a
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -G ${CMAKE_GENERATOR} ../Geos
    )
    SetProjectDependencies(TARGET Geos DEPENDS Python)
endif()
