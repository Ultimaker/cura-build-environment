add_custom_target(PythonPackagesGeneral ALL
        COMMAND ${Python3_EXECUTABLE} -m pip install --require-hashes -r  ${CMAKE_CURRENT_SOURCE_DIR}/requirements.txt
        COMMENT "Install Python packages"
        DEPENDS Python
        )