set(qt_url http://download.qt.io/official_releases/qt/5.7/5.7.0/single/qt-everywhere-opensource-src-5.7.0.tar.gz)
set(qt_md5 9a46cce61fc64c20c3ac0a0e0fa41b42)

# Qt uses different sources for Windows
if(BUILD_OS_WINDOWS)
    set(qt_url http://download.qt.io/official_releases/qt/5.6/5.6.1-1/single/qt-everywhere-opensource-src-5.6.1-1.zip)
    set(qt_md5 9d7ea0cadcec7b5a63e8e83686756978)
endif()

set(qt_options
    -release
    -prefix ${CMAKE_INSTALL_PREFIX}
    -archdatadir ${CMAKE_INSTALL_PREFIX}/lib
    -datadir ${CMAKE_INSTALL_PREFIX}/share
    -opensource
    -confirm-license
    -no-gtk
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

ExternalProject_Add(Qt
    URL ${qt_url}
    URL_MD5 ${qt_md5}
    CONFIGURE_COMMAND ./configure ${qt_options}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Qt)
