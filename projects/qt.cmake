set(qt_url http://download.qt.io/official_releases/qt/5.6/5.6.2/single/qt-everywhere-opensource-src-5.6.2.tar.gz)
set(qt_md5 1b1b1f929d0cd83680354a0c83d8e945)

# Qt uses different sources for Windows
# However, not used anyway, because PyQt5 already comes with it's own Qt libraries
if(BUILD_OS_WINDOWS)
    set(qt_url http://download.qt.io/official_releases/qt/5.6/5.6.2/single/qt-everywhere-opensource-src-5.6.2.zip)
    set(qt_md5 b684a2f37b1beebd421b3b7d1eca15dc)
endif()

set(qt_options
    -release
    -prefix ${CMAKE_INSTALL_PREFIX}
    -archdatadir ${CMAKE_INSTALL_PREFIX}/lib
    -datadir ${CMAKE_INSTALL_PREFIX}/share
    -opensource
    -confirm-license
    -nomake examples
    -nomake tests
    -nomake tools
    -no-cups
    -no-sql-db2
    -no-sql-ibase
    -no-sql-mysql
    -no-sql-oci
    -no-sql-odbc
    -no-sql-psql
    -no-sql-sqlite
    -no-sql-sqlite2
    -no-sql-tds
    -skip qtconnectivity
    -skip qtdoc
    -skip qtenginio
    -skip qtlocation
    -skip qtmultimedia
    -skip qtscript
    -skip qtsensors
    -skip qtwebchannel
    -skip qtwebengine
    -skip qtwebsockets
    -skip qtandroidextras
    -skip qtactiveqt
    -skip qttools
    -skip qtxmlpatterns
    -skip qt3d
    -skip qtcanvas3d
    -skip qtserialport
    -skip qtwayland
)

if(BUILD_OS_OSX)
    list(APPEND qt_options -no-framework)
elseif(BUILD_OS_WINDOWS)
    list(APPEND qt_options -opengl desktop)
elseif(BUILD_OS_LINUX)
    list(APPEND qt_options -no-rpath -qt-xcb)
endif()

# Using Qt libraries shipped via PyQt on Windows
# (For more details take a look at the PyQt recipe)
# Other OSs will build it manually...
if(NOT BUILD_OS_WINDOWS)
    ExternalProject_Add(Qt
        URL ${qt_url}
        URL_MD5 ${qt_md5}
        CONFIGURE_COMMAND ${qt_configure_command} ${qt_options}
        BUILD_IN_SOURCE 1
    )
    SetProjectDependencies(TARGET Qt)
endif()