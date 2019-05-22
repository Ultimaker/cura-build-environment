# Installing lxml via pip on the Linux CI server is not working at the moment.
# This is for the fmd_materials validation script. Disable this project for now.
return()

add_custom_target(lxml
    COMMAND ${Python3_EXECUTABLE} -m pip install lxml==4.3.0
    COMMENT "Install lxml"
)

if(NOT BUILD_OS_WINDOWS)
    SetProjectDependencies(TARGET lxml DEPENDS libxslt libxml2 Python)
else()
    SetProjectDependencies(TARGET lxml DEPENDS Python)
endif()
