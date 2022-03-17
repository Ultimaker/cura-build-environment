#Copyright (c) 2022 Ultimaker B.V.
#cura-build-environment is released under the terms of the AGPLv3 or higher.

GetFromEnvironmentOrCache(
        NAME
            SAVITAR_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for Savitar")

set(extra_cmake_args "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args
      -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs
	  -DMSVC_STATIC_RUNTIME=OFF
    )
endif()

ExternalProject_Add(Savitar
    GIT_REPOSITORY https://github.com/ultimaker/libSavitar.git
    GIT_TAG origin/${SAVITAR_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
               -DCMAKE_CXX_STANDARD=17
               -DBUILD_STATIC=OFF
               ${extra_cmake_args}
	       BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
	       INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install || echo "ignore error"
)

SetProjectDependencies(TARGET Savitar DEPENDS Python)
