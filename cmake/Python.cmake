# Copyright (c) 2022 Ultimaker B.V.

if(NOT Python_FOUND)
    GetFromEnvironmentOrCache(
            NAME
                Python_VERSION
            DEFAULT
                3.10
            DESCRIPTION
                "Python Version to use"
            REQUIRED)
    if(APPLE)
        set(Python_FIND_FRAMEWORK NEVER)
    endif()
    find_package(Python ${Python_VERSION} EXACT REQUIRED COMPONENTS Interpreter Development)
    message(STATUS "Using Python ${Python_VERSION}")
endif()