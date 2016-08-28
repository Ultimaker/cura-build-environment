ExternalProject_Add(CuraEngine
    GIT_REPOSITORY https://github.com/ultimaker/CuraEngine
    GIT_TAG origin/master
    CMAKE_COMMAND PATH=${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib/ PYTHONPATH=${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages/ cmake
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCURA_ENGINE_VERSION=${CURA_VERSION} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

SetProjectDependencies(TARGET CuraEngine DEPENDS Arcus)
