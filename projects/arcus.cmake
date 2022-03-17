#Copyright (c) 2022 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
		NAME
			ARCUS_BRANCH_OR_TAG
		DEFAULT
			master
		DESCRIPTION
			"The name of the tag or branch to build for Arcus")

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args
        -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs
        -DMSVC_STATIC_RUNTIME=OFF
        -DCMAKE_EXE_LINKER_FLAGS=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_EXE_LINKER_FLAGS_RELEASE=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_MODULE_LINKER_FLAGS=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_MODULE_LINKER_FLAGS_RELEASE=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_SHARED_LINKER_FLAGS=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_SHARED_LINKER_FLAGS_RELEASE=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_STATIC_LINKER_FLAGS=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
        -DCMAKE_STATIC_LINKER_FLAGS_RELEASE=/LIBPATH:"${CMAKE_INSTALL_PREFIX}/libs" /machine:x64
    )
endif()

ExternalProject_Add(Arcus
    GIT_REPOSITORY https://github.com/ultimaker/libArcus.git
    GIT_TAG origin/${ARCUS_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_CXX_STANDARD=17
               -DBUILD_STATIC=OFF
               -DBUILD_PYTHON=ON
               -DBUILD_EXAMPLES=OFF
               ${extra_cmake_args}
	       BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
	       INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
)

SetProjectDependencies(TARGET Arcus DEPENDS Python Protobuf)

if(BUILD_OS_WINDOWS)
    ExternalProject_Add(Arcus-MinGW
        GIT_REPOSITORY https://github.com/ultimaker/libArcus.git
        GIT_TAG origin/${ARCUS_BRANCH_OR_TAG}
        GIT_SHALLOW 1
        CMAKE_GENERATOR "MinGW Makefiles"
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                   -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                   -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib-mingw
                   -DCMAKE_CXX_STANDARD=17
                   -DBUILD_STATIC=ON
                   -DBUILD_PYTHON=OFF
                   -DBUILD_EXAMPLES=OFF
                   ../Arcus-MinGW
        BUILD_COMMAND mingw32-make
        INSTALL_COMMAND mingw32-make install
    )

    SetProjectDependencies(TARGET Arcus-MinGW DEPENDS Protobuf-MinGW Arcus)
endif()
