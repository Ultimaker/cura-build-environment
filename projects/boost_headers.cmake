#Copyright (c) 2020 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

if(NOT TARGET BoostHeaders)
    ExternalProject_Add(BoostHeaders
        URL http://sourceforge.net/projects/boost/files/boost/1.67.0/boost_1_67_0.tar.bz2
        URL_HASH SHA256=2684c972994ee57fc5632e03bf044746f6eb45d4920c343937a465fd67a5adba
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND "${CMAKE_COMMAND}" -E copy_directory "${CMAKE_CURRENT_BINARY_DIR}/BoostHeaders-prefix/src/BoostHeaders/boost" "${CMAKE_INSTALL_PREFIX}/include/boost"
    )
endif()