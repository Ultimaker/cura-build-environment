set(savitar_cmake_command ${CMAKE_COMMAND})

set(extra_cmake_args "")
set(SAVITAR_pyd_copy_dir "")
if(BUILD_OS_WINDOWS)
    set(extra_cmake_args
      -DCMAKE_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/libs
	  -DMSVC_STATIC_RUNTIME=OFF
    )
	set(SAVITAR_pyd_copy_dir "lib.win-amd64-3.10")
else()
  if(BUILD_OS_OSX)
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
	set(SAVITAR_pyd_copy_dir "lib.macosx-10.14-x86_64-3.10")
  else()
    set(SAVITAR_pyd_copy_dir "lib.linux-x86_64-3.10")
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
               -DCMAKE_CXX_STANDARD=17
               -DBUILD_STATIC=OFF
			   -DPY_DEPEND_BIN_INSTALL_DIR=${CMAKE_INSTALL_PREFIX}/lib/site-packages
               ${extra_cmake_args}
	BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} || echo "ignore error"
    COMMAND ${CMAKE_MAKE_PROGRAM}
    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_BINARY_DIR}/Savitar-prefix/src/Savitar-build/build/Savitar/build/${SAVITAR_pyd_copy_dir}" "${CMAKE_INSTALL_PREFIX}/lib/site-packages/" || dir "${CMAKE_CURRENT_BINARY_DIR}/Savitar-prefix/src/Savitar-build/build/Savitar/build"
)

SetProjectDependencies(TARGET Savitar DEPENDS Python)
