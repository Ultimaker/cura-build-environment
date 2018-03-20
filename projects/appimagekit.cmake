if(BUILD_OS_LINUX)
    ExternalProject_Add(AppImageKit
        GIT_REPOSITORY https://github.com/probonopd/AppImageKit.git
        GIT_TAG f72e74c7e22449fb3c1663ac86fb1f8bba7ab9fb
        GIT_SUBMODULES cmake/sanitizers-cmake
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        INSTALL_COMMAND ""
        BUILD_IN_SOURCE 1
    )

    # Copying all AppImageKit tools into our prefix manually
    # AppImageKit doesn't provide its own install routine...
    # (https://github.com/probonopd/AppImageKit/issues/222)
    add_custom_command(
        TARGET AppImageKit
        POST_BUILD
        DEPENDS AppImageKit
        COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/AppImageKit-prefix/src/AppImageKit/src/appimaged    ${CMAKE_INSTALL_PREFIX}/bin/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/AppImageKit-prefix/src/AppImageKit/src/appimagetool ${CMAKE_INSTALL_PREFIX}/bin/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/AppImageKit-prefix/src/AppImageKit/src/AppRun       ${CMAKE_INSTALL_PREFIX}/bin/
    )
endif()
