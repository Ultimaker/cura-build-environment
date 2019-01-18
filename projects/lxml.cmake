add_custom_target(lxml
    COMMAND ${PYTHON_EXECUTABLE} -m pip install lxml==4.3.0
    COMMENT "Install lxml"
)

if(NOT BUILD_OS_WINDOWS)
    SetProjectDependencies(TARGET lxml DEPENDS libxslt libxml2 Python)
else()
    SetProjectDependencies(TARGET lxml DEPENDS Python)
endif()
