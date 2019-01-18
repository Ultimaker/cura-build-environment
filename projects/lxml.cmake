add_custom_target(install_lxml)

add_custom_command(
    TARGET install_lxml PRE_BUILD
    COMMAND ${PYTHON_EXECUTABLE} -m pip install lxml==4.3.0
    COMMENT "Install lxml"
)

if(NOT BUILD_OS_WINDOWS)
    add_dependencies(install_lxml libxslt libxml2 Python)
endif()
