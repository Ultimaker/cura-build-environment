GetFromEnvironmentOrCache(
        NAME
            CURA_BRANCH_OR_TAG
        DEFAULT
            master
        DESCRIPTION
            "The name of the tag or branch to build for Cura")

GetFromEnvironmentOrCache(
        NAME
            CURA_DEBUGMODE
        DEFAULT
            OFF
        DESCRIPTION
            "Enable crash handler and other debug options in Cura"
        BOOL)
GetFromEnvironmentOrCache(
        NAME
            CURA_CLOUD_API_ROOT
        DESCRIPTION
            "The cloud API root")
GetFromEnvironmentOrCache(
        NAME
            CURA_CLOUD_ACCOUNT_API_ROOT
        DESCRIPTION
            "The cloud account API root")
GetFromEnvironmentOrCache(
        NAME
            CURA_DIGITAL_FACTORY_URL
        DESCRIPTION
            "The Ultimaker Digital Factory URL")
GetFromEnvironmentOrCache(
        NAME
            CURA_MARKETPLACE_ROOT
        DESCRIPTION
            "The Cura Marketplace API root URL")
GetFromEnvironmentOrCache(
        NAME
            URANIUM_SCRIPTS_DIR
        DESCRIPTION
            "The Uranium script directory")
GetFromEnvironmentOrCache(
        NAME
            CURA_NO_INSTALL_PLUGINS
        DESCRIPTION
            "A list of plugins to exclude from installation, should be separated by ','.")
GetFromEnvironmentOrCache(
        NAME
            CURA_BUILDTYPE
        DESCRIPTION
            "Build type of Cura, eg. 'Enterprise'")

ExternalProject_Add(Cura
    GIT_REPOSITORY https://github.com/ultimaker/Cura
    GIT_TAG ${CURA_BRANCH_OR_TAG}
    GIT_SHALLOW 1
    STEP_TARGETS update
    CMAKE_GENERATOR ${CMAKE_GENERATOR}
    CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
               -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
               -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
               -DPython_ROOT=${Python_ROOT}
               -DPython_SITELIB_LOCAL=${Python_SITELIB_LOCAL}
               -DURANIUM_SCRIPTS_DIR=${URANIUM_SCRIPTS_DIR}
               -DCURA_VERSION=${CURA_VERSION}
               -DCURA_BUILDTYPE=${CURA_BUILDTYPE}
               -DCURA_DEBUGMODE=${CURA_DEBUGMODE}
               -DCURA_CLOUD_API_ROOT=${CURA_CLOUD_API_ROOT}
               -DCURA_CLOUD_API_VERSION=${CURA_CLOUD_API_VERSION}
               -DCURA_CLOUD_ACCOUNT_API_ROOT=${CURA_CLOUD_ACCOUNT_API_ROOT}
               -DCURA_DIGITAL_FACTORY_URL=${CURA_DIGITAL_FACTORY_URL}
               -DCURA_MARKETPLACE_ROOT=${CURA_MARKETPLACE_ROOT}
               -DCURA_NO_INSTALL_PLUGINS=${CURA_NO_INSTALL_PLUGINS})
add_dependencies(Cura install-python-requirements Arcus Savitar Uranium CuraEngine pynest2d Charon)
