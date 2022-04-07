install(DIRECTORY ${ULTIMAKER_CURA_PATH}/
        DESTINATION "."
        USE_SOURCE_PERMISSIONS
        COMPONENT "_cura" # Note: _ prefix is necessary to make sure the Cura component is always listed first
        )

if (CURA_BUILDTYPE STREQUAL "")
    cpack_add_component(_cura
            DISPLAY_NAME "Ultimaker Cura"
            Description "Ultimaker Cura Executable and Data Files"
            REQUIRED
            )
else ()
    cpack_add_component(_cura
            DISPLAY_NAME "Ultimaker Cura ${CURA_BUILDTYPE}"
            Description "Ultimaker Cura ${CURA_BUILDTYPE} Executable and Data Files"
            REQUIRED
            )
endif ()

include(InstallRequiredSystemLibraries)
install (PROGRAMS ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS} DESTINATION ".")

# ========================================
# CPack Common Settings
# ========================================

if (CURA_BUILDTYPE STREQUAL "")
    set(CPACK_PACKAGE_NAME "Ultimaker Cura")
else ()
    set(CPACK_PACKAGE_NAME "Ultimaker Cura ${CURA_BUILDTYPE}")
endif ()
string(REPLACE " " "_" CPACK_FILE_NAME_NO_SPACES "${CPACK_PACKAGE_NAME}")

set(CPACK_PACKAGE_VENDOR "Ultimaker B.V.")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://ultimaker.com")

# MSI only supports version format like "x.x.x.x" where x is an integer from 0 to 65534
set(CPACK_PACKAGE_VERSION_MAJOR ${CURA_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${CURA_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${CURA_VERSION_PATCH})

# Use full version x.x.x string in install directory for both installers,
# so that IT can easily automatically upgrade to a newer patch version,
# but also uninstall only the desired EXE installation. Also differentiate
# between build types
if (CURA_BUILDTYPE STREQUAL "")
    set(CPACK_PACKAGE_NAME "Ultimaker Cura ${CURA_VERSION}")
else ()
    set(CPACK_PACKAGE_NAME "Ultimaker Cura ${CURA_BUILDTYPE} ${CURA_VERSION}")
endif ()

set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/packaging/Cura.ico")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Ultimaker Cura - 3D Printing Software")
set(CPACK_PACKAGE_CONTACT "Ultimaker Cura <software-cura@ultimaker.com>")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/packaging/cura_license.txt")
set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/packaging/Cura.ico")

# Differentiate between a normal Cura installation and that of a different build type
if (CURA_BUILDTYPE STREQUAL "")
    set(CPACK_CREATE_DESKTOP_LINKS Cura "Ultimaker Cura ${CURA_VERSION}")
    set(CPACK_PACKAGE_EXECUTABLES Cura "Ultimaker Cura ${CURA_VERSION}")
    set(CPACK_PACKAGE_INSTALL_DIRECTORY "Ultimaker Cura ${CURA_VERSION}")
else ()
    set(CPACK_CREATE_DESKTOP_LINKS Cura "Ultimaker Cura ${CURA_BUILDTYPE} ${CURA_VERSION}")
    set(CPACK_PACKAGE_EXECUTABLES Cura "Ultimaker Cura ${CURA_BUILDTYPE} ${CURA_VERSION}")
    set(CPACK_PACKAGE_INSTALL_DIRECTORY "Ultimaker Cura ${CURA_BUILDTYPE} ${CURA_VERSION}")
endif ()

# Use processor name
STRING(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" CPACK_SYSTEM_NAME)
set(CPACK_PACKAGE_FILE_NAME "${CPACK_FILE_NAME_NO_SPACES}-${CURA_VERSION}-${CPACK_SYSTEM_NAME}")

set(CPACK_THREADS -1)
