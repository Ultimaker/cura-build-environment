if(BUILD_OS_WINDOWS)
    add_custom_target(PyWin32
        COMMAND ${PYTHON_EXECUTABLE} -m pip install pypiwin32
        COMMENT "Installing PyWin32"
    )

    SetProjectDependencies(TARGET PyWin32 DEPENDS Python)
endif()
