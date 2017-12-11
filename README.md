cura-build-environment
======================

This is a CMake-based project that will build the dependencies for Cura.

It will download and build the following projects:

- Python (Version 3.5)
- Qt (Not on Windows)
- Sip
- PyQt (Installs Wheel on Windows)
- OpenBLAS (Only on Linux)
- Numpy (Installs Wheel on Windows)
- Scipy (Installs Wheel on Windows)
- Protobuf
- Arcus
- python-netifaces
- python-six
- python-zeroconf
- pyserial
- Savitar
- cx_Freeze
- AppImageKit (Only on Linux)
- python-utils
- Numpy-STL

In addition, there is an option "INCLUDE_DEVEL", which, when set to ON, will
also download and install a set of development tools. The following projects
are currently installed as development tools:

- astroid
- isort
- py
- typed-ast
- pytest
- pylint
- mypy

The end result of this project should be a complete build environment
installed to CMAKE_INSTALL_PREFIX. This environment can be used in
combination with the [cura-build] repository to produce Cura executables for
all three supported platforms.

[cura-build]: https://github.com/ultimaker/cura-build

Building
--------

To build this project, clone this project to a directory - referred to as
$SOURCE_DIR below - then determine where you want to install everything.
This will be referred to as $INSTALL_DIR below.

On all platforms, you will need CMake and Git installed.

### Linux

Building on Linux is fairly straightforward:

```
cd $SOURCE_DIR
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release
make
```

Note that a fairly recent C++ compiler is required, at the very least GCC
4.9. If you are building on CentOS, you can get this from the devtoolset
packages.

### Mac OS

Building on MacOS currently requires OpenSSL and a recent version of the
development tools distributed with XCode. You may also want to set
MACOSX_DEPLOYMENT_TARGET to ensure everything can be used with older
versions of Mac OS. The "env_osx.sh" will set it to 10.7 and ensure the
right compiler is still used. It also add the relevant directories for
OpenSSL installed through Brew.

On newer versions of MacOS, the zlib headers cannot be found unless
XCode Command Line Tools are installed first. To install those, please
run the following first:

```
xcode-select --install
```

To build, run the following:

```
cd $SOURCE_DIR
mkdir build
cd build
../env_osx.sh
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release
make
```

### Windows

Building the environment on Windows requires both MinGW (version 4.9 or
higher) and Visual C++ 2015 or Visual Studio 2017 with Windows 8.1 SDK.
Visual C++ is required for building Python and MinGW for building the Cura Engine.
In addition, Subversion is required for building Python. Please make sure all required tools are 
accessible through your path.

The `env_win32.bat` and `env_win64.bat` will make sure to set a few
environment variables that are required. Most importantly, they call the
`vcvarsall.bat` files from Visual C++ to ensure VC++ can be used.

To build, run the following:

```
cd %SOURCE_DIR%
mkdir build
cd build
..\env_win64.bat
cmake .. -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% -DCMAKE_BUILD_TYPE=Release ^
         -G "NMake Makefiles"
nmake
```

Note: Using the NMake Makefiles generator is important, since the normal
Visual Studio generator does not work well in combination with some of
the build systems of the sub-projects that are built.
