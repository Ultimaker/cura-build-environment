set(_cura_openctm_url https://sourceforge.net/projects/openctm/files/OpenCTM-1.0.3/OpenCTM-1.0.3-src.tar.bz2/download)
set(_cura_openctm_sha256 4a8d2608d97364f7eec56b7c637c56b9308ae98286b3e90dbb7413c90e943f1d)

if (BUILD_OS_WINDOWS)
    ExternalProject_Add(OpenCTM
        URL      ${_cura_openctm_url}
        URL_HASH SHA256=${_cura_openctm_sha256}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND nmake /f Makefile.msvc openctm
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy lib/openctm.dll ${CMAKE_INSTALL_PREFIX}/bin/openctm.dll
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctm.lib ${CMAKE_INSTALL_PREFIX}/lib/openctm.lib
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctm.h   ${CMAKE_INSTALL_PREFIX}/include/openctm.h
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctmpp.h ${CMAKE_INSTALL_PREFIX}/include/openctmpp.h
        BUILD_IN_SOURCE 1
    )
elseif (BUILD_OS_LINUX)
    ExternalProject_Add(OpenCTM
        URL      ${_cura_openctm_url}
        URL_HASH SHA256=${_cura_openctm_sha256}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make -f Makefile.linux openctm
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy lib/libopenctm.so ${CMAKE_INSTALL_PREFIX}/lib/libopenctm.so
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctm.h     ${CMAKE_INSTALL_PREFIX}/include/openctm.h
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctmpp.h   ${CMAKE_INSTALL_PREFIX}/include/openctmpp.h
        BUILD_IN_SOURCE 1
    )
else ()  # OSX
    ExternalProject_Add(OpenCTM
        URL      ${_cura_openctm_url}
        URL_HASH SHA256=${_cura_openctm_sha256}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make -f Makefile.macosx openctm
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy lib/libopenctm.dylib ${CMAKE_INSTALL_PREFIX}/lib/libopenctm.dylib
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctm.h        ${CMAKE_INSTALL_PREFIX}/include/openctm.h
                COMMAND ${CMAKE_COMMAND} -E copy lib/openctmpp.h      ${CMAKE_INSTALL_PREFIX}/include/openctmpp.h
        BUILD_IN_SOURCE 1
    )
endif ()
