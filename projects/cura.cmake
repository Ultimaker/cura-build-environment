ExternalProject_Add(Cura
    GIT_REPOSITORY https://github.com/ultimaker/Cura
    GIT_TAG origin/master
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DURANIUM_SCRIPTS_DIR= -DCURA_VERSION=${CURA_VERSION}
)

SetProjectDependencies(TARGET Cura DEPENDS Uranium CuraEngine)
