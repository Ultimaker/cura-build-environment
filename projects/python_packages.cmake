add_custom_target(PythonPackagesGeneral ALL
    COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r  ${CMAKE_SOURCE_DIR}/projects/requirements.txt
    COMMENT "Install Python packages"
    DEPENDS Python
)

if(BUILD_OS_WINDOWS)
    add_custom_command(
        TARGET PythonPackagesGeneral POST_BUILD
        COMMAND powershell -Command "(gc hooks.py) -replace 'libffi-7.dll', 'libffi-8.dll' | Out-File -encoding ASCII hooks.py"
        COMMENT "Make libffi-8.dll visible to cx_Freeze"
        WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/lib/site-packages/cx_Freeze
    )
endif()
if(BUILD_OS_OSX)
    # These are plug-ins in Qt where PyQt6-Qt6 does provide the bindings, but doesn't provide the binaries they need.
    # Normally this isn't a problem, but on MacOS the packaging checks these dependencies and then fails to package them.
    # Excluding them from the packager makes no difference. Deleting the files outright does.
    add_custom_command(
        TARGET PythonPackagesGeneral POST_BUILD
        COMMAND rm -r "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/PyQt6/Qt6/qml/QtQml/XmlListModel"
        COMMAND rm -r "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/PyQt6/Qt6/qml/QtQuick/Scene2D"
        COMMAND rm -r "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/PyQt6/Qt6/qml/QtQuick/Scene3D"
        COMMAND rm -r "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/PyQt6/Qt6/qml/QtQuick/LocalStorage"
        COMMAND rm -r "${CMAKE_INSTALL_PREFIX}/lib/python3.10/site-packages/PyQt6/Qt6/qml/QtQuick/NativeStyle"
    )
endif()
