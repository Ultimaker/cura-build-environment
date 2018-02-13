if(BUILD_OS_LINUX)
    set(savitar_cmake_command PATH=${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib/ PYTHONPATH=${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.5:${CMAKE_INSTALL_PREFIX}/lib/python3.5/site-packages/ ${CMAKE_COMMAND})
else()
    set(savitar_cmake_command ${CMAKE_COMMAND})
endif()

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -DPYTHON_LIBRARY=${CMAKE_INSTALL_PREFIX}/libs/python35.lib -DPYTHON_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include -DPYTHON_SITE_PACKAGES_DIR=lib/site-packages)
endif()

ExternalProject_Add(Savitar
    GIT_REPOSITORY https://github.com/ultimaker/libSavitar.git
    GIT_TAG origin/master
    CMAKE_COMMAND ${savitar_cmake_command}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_STATIC=ON -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX} ${extra_cmake_args}
)

SetProjectDependencies(TARGET Savitar DEPENDS Sip)
