# Additional dependencies: libfuse-dev

ExternalProject_Add(AppImageKit
    GIT_REPOSITORY https://github.com/probonopd/AppImageKit.git
    GIT_TAG origin/master
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    INSTALL_COMMAND ""
    BUILD_IN_SOURCE 1
)

# Copying all AppImageKit tools into our prefix manually
# AppImageKit doesn't provide its own install routine...
# (https://github.com/probonopd/AppImageKit/issues/222)
add_custom_command(
    TARGET AppImageKit POST_BUILD
    COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
    COMMAND ${CMAKE_COMMAND} -E copy AppImageAssistant ${CMAKE_INSTALL_PREFIX}/bin/
    COMMAND ${CMAKE_COMMAND} -E copy AppImageExtract   ${CMAKE_INSTALL_PREFIX}/bin/
    COMMAND ${CMAKE_COMMAND} -E copy AppImageMonitor   ${CMAKE_INSTALL_PREFIX}/bin/
    COMMAND ${CMAKE_COMMAND} -E copy AppRun            ${CMAKE_INSTALL_PREFIX}/bin/
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/AppImageKit-prefix/src/AppImageKit/
)

SetProjectDependencies(TARGET AppImageKit)
