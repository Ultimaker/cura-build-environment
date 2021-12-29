add_custom_target(PythonPackagesGeneral ALL
    COMMAND LD_FLAGS="-L${CMAKE_INSTALL_PREFIX}" ${Python3_EXECUTABLE} -m pip install --require-hashes -r  ${CMAKE_SOURCE_DIR}/projects/requirements.txt
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
