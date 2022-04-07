# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

# Only NSIS needs to have arduino and vcredist
install(DIRECTORY ${CMAKE_INSTALL_PREFIX}/arduino
        DESTINATION "."
        COMPONENT "arduino"
        )

install(FILES ${CMAKE_INSTALL_PREFIX}/VC_redist.x64.exe
        DESTINATION "."
        COMPONENT "vcredist"
        )

cpack_add_component(vcredist DISPLAY_NAME "Visual Studio 2015-2022 Redistributable")
cpack_add_component(arduino DISPLAY_NAME "Arduino Drivers")

set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_EXECUTABLES_DIRECTORY ".")
set(CPACK_NSIS_STARTMENU_DIRECTORY "Ultimaker Cura")
set(CPACK_NSIS_DISPLAY_NAME "Ultimaker Cura")
set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}\\\\packaging\\\\Cura.ico")
set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}\\\\packaging\\\\Cura.ico")
set(CPACK_NSIS_INSTALLED_ICON_NAME "Ultimaker-Cura.exe")
set(CPACK_NSIS_HELP_LINK "https://github.com/Ultimaker/Cura")
set(CPACK_NSIS_URL_INFO_ABOUT "https://ultimaker.com/en/support/software")
set(CPACK_NSIS_MENU_LINKS
        "https://ultimaker.com/en/support/software" "Online Documentation"
        "https://github.com/Ultimaker/Cura" "Development Resources"
        )

set(CPACK_NSIS_MUI_WELCOMEFINISHPAGE_BITMAP ${CMAKE_SOURCE_DIR}\\\\packaging\\\\cura_banner_nsis.bmp)
set(CPACK_NSIS_MUI_UNWELCOMEFINISHPAGE_BITMAP ${CMAKE_SOURCE_DIR}\\\\packaging\\\\cura_banner_nsis.bmp)
set(CPACK_NSIS_INSTALLER_MUI_FINISHPAGE_RUN_CODE "!define MUI_FINISHPAGE_RUN \\\"$WINDIR\\\\explorer.exe\\\"\n!define MUI_FINISHPAGE_RUN_PARAMETERS \\\"$INSTDIR\\\\Ultimaker-Cura.exe\\\"") # Hack to ensure Cura is not started with admin rights

add_custom_target(packaging
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/packaging/NSIS "${CMAKE_CURRENT_BINARY_DIR}/_CPack_Packages/${CPACK_SYSTEM_NAME}/NSIS"
        COMMENT "Copying NSIS scripts from [${CMAKE_SOURCE_DIR}/packaging/NSIS] to [${CMAKE_CURRENT_BINARY_DIR}/_CPack_Packages/${CPACK_SYSTEM_NAME}/NSIS]"
        COMMAND "${CMAKE_COMMAND}" --build . --target package
        WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
        COMMENT  "Package into a NSIS installer."
        VERBATIM
        )
add_dependencies(packaging pyinstaller)