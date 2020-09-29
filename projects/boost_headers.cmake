#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

if(NOT TARGET BoostHeaders)
    ExternalProject_Add(BoostHeaders
        URL http://sourceforge.net/projects/boost/files/boost/1.67.0/boost_1_67_0.tar.bz2
        URL_HASH SHA1=694ae3f4f899d1a80eb7a3b31b33be73c423c1ae
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND "${CMAKE_COMMAND}" -E copy_directory "${CMAKE_CURRENT_BINARY_DIR}/BoostHeaders-prefix/src/BoostHeaders/boost" "${CMAKE_INSTALL_PREFIX}/include/boost"
    )
endif()