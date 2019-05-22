set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args -DPYTHON_LIBRARY=${CMAKE_INSTALL_PREFIX}/libs/python35.lib -DPYTHON_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include -DPYTHON_SITE_PACKAGES_DIR=lib/site-packages -DMSVC_STATIC_RUNTIME=ON)
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

ExternalProject_Add(Arcus
    GIT_REPOSITORY https://github.com/ultimaker/libArcus.git
    GIT_TAG origin/${CURA_ARCUS_BRANCH_OR_TAG}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_STATIC=ON -DBUILD_EXAMPLES=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX} ${extra_cmake_args}
)

SetProjectDependencies(TARGET Arcus DEPENDS Sip Protobuf)

if(BUILD_OS_WINDOWS)
    ExternalProject_Add(Arcus-MinGW
        GIT_REPOSITORY https://github.com/ultimaker/libArcus.git
        GIT_TAG origin/${CURA_ARCUS_BRANCH_OR_TAG}
        CMAKE_GENERATOR "MinGW Makefiles"
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_INSTALL_LIBDIR=lib-mingw -DBUILD_STATIC=ON -DBUILD_EXAMPLES=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DPROTOBUF_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib-mingw/libprotobuf.a -DBUILD_PYTHON=OFF
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )

    SetProjectDependencies(TARGET Arcus-MinGW DEPENDS Sip Protobuf-MinGW Arcus)
endif()


