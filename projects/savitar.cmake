if(BUILD_OS_LINUX)
    set(savitar_cmake_command PATH=${CMAKE_INSTALL_PREFIX}/bin/:$ENV{PATH} LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib/ PYTHONPATH=${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/:${CMAKE_INSTALL_PREFIX}/lib/python3.8:${CMAKE_INSTALL_PREFIX}/lib/python3.8/site-packages/ ${CMAKE_COMMAND})
else()
    set(savitar_cmake_command ${CMAKE_COMMAND})
endif()

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs)
elseif(BUILD_OS_OSX)
    if(CMAKE_OSX_DEPLOYMENT_TARGET)
        list(APPEND extra_cmake_args
            -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
        )
    endif()
    if(CMAKE_OSX_SYSROOT)
        list(APPEND extra_cmake_args
            -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
        )
    endif()
endif()

ExternalProject_Add(Savitar
    GIT_REPOSITORY https://github.com/ultimaker/libSavitar.git
    GIT_TAG origin/${CURA_SAVITAR_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    CMAKE_COMMAND ${savitar_cmake_command}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
               -DBUILD_STATIC=ON
               ${extra_cmake_args}
)

SetProjectDependencies(TARGET Savitar DEPENDS Sip)
