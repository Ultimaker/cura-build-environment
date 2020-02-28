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

To build these dependencies of Cura, the following software needs to be installed on your system:

- **CMake** Once CMake is installed make sure it is available on your `%PATH%`. Check this by running `cmake --version` in the Windows console. (http://www.cmake.org/)
- **git** - The `git` command should be available on your `%PATH%` or `$PATH`, depending which OS you are using. (https://git-scm.com/)
  - (WINDOWS) Make sure that the `cmd` directory in the git for windows installation directory is on the `%PATH%` and *not* its `bin` directory, otherwise mingw32 will complain about `sh.exe` being on the path. (https://git-for-windows.github.io/)
  - (LINUX) Check your package management system for the term `git`. You should be able to find easily there.
- **Subversion aka "svn"** - To fetch some sources

On Linux, the following dependencies are required in order to build Qt:
- pkg-config
- freetype
- xcb
- opengl-desktop
- fontconfig

The end result of this project should be a complete build environment
installed to CMAKE_INSTALL_PREFIX. This environment can be used in
combination with the [cura-build] repository to produce Cura executables for
all three supported platforms.

[cura-build]: https://github.com/ultimaker/cura-build


# Docker Images (Linux and Windows)

The lastest docker images can be found on DockerHub via https://hub.docker.com/r/ultimaker/cura-build-environment.
Currently only the CentOS-based images are available. To get the latest CentOS-base image, you can run

```shell script
docker pull ultimaker/cura-build-environment
```

There are Dockerfiles for Linux and Windows. You can find them in the `docker`
directory. The main Dockerfiles are as follows:

  - `docker/linux/Dockerfile.centos`: Based on centos7
  - `docker/windows/Dockerfile.vs2015`: Based on Windows Server Core 1809 with
    Visual Studio 2015 Build Tools

To build a docker, you can use the commands below:

```shell script
# Make sure that you are in the `cura-build-environment` root directory.

# Build the Linux image based on centos7
docker build -t <your-image-tag> -f docker/linux/Dockerfile.centos .
```

```powershell
# Build the Windows image based on Windows Server Core 1809 with
# Visual Studio 2015 Build Tools
docker build -t <your-image-tag> -f docker/windows/Dockerfile.vs2015 .
```

Note that the Windows Dockerfile uses `mcr.microsoft.com/windows/servercore:1809-amd64`
as the base image. See https://hub.docker.com/_/microsoft-windows-servercore): "Windows
requires the host OS version to match the container OS version." So, if the `1809` base
image doesn't work for you, try to change it to an eariler version, for example `1607`.
To check your Windows version, you can run the PowerShell command below:

```powershell
PS > [System.Environment]::OSVersion.Version

Major  Minor  Build  Revision
-----  -----  -----  --------
10     0      17763  0
```

**IMPORTANT:** There's a known issue with Windows docker images earlier than version `1809`
that CMake git clone and submodule commands can fail due to SSL verification. In
cura-build-environment, this can happen for `libArcus` and `libSavitar`. A workaround is
to use the `GIT_CONFIG` option in `ExternalProject_Add()` to disable SSL verification.
To do so, add the following line:

```
ExternalProject_Add(myProj
  GIT_REPOSITORY  https://github.com/my/project
  ...
  GIT_CONFIG      http.sslVerify=false
  ...
)
```

The built cura-build-environment will be installed in the following paths in the
docker images:
  - `Linux` : `/srv/cura-build-environment`
  - `Windows` : `C:\cura-build-environment`

There are 2 main environment variables in the image:

 - `CURA_BUILD_ENV_BUILD_TYPE`: The build type, either `Release` (default) or
   `Debug`.
 - `CURA_BUILD_ENV_PATH`: Where the cura-build-environment is installed.

You can use a number of arguments to customize the image you want to build. The
available arugments are as follows:

 - `CURA_BUILD_ENV_BUILD_TYPE`: By default `Release`, this is passed to cmake via `CMAKE_BUILD_TYPE`.
 - `CURA_BUILD_ENV_PATH`: Where the cura-build-environment will be installed in the image.
 - `CURA_ARCUS_BRANCH_OR_TAG`: The git branch/tag to use for building libArcus.
 - `CURA_SAVITAR_BRANCH_OR_TAG`: The git branch/tag to use for building libSavitar.

You can configure them via the example command below:

```bash
docker build \
    --build-arg CURA_BUILD_ENV_BUILD_TYPE=Release \
    --build-arg CURA_ARCUS_BRANCH_OR_TAG=master \
    ...
```

## Details about the Linux CentOS 7 Docker Image

The default user is `ultimaker` with `uid=1000` and group `ultimaker` with
`gid=1000`. This ensures if volume mounting is used, the resulting files should
have the correct ownerships which corresponds to the default linux user on the
host machine.

The development tool in use is `devtoolset-7`. In order to use the build
environment correctly in the docker container, make sure that the following
is done before you do anything else:

```bash
#!/bin/bash

# Enable devtoolset-7 with its environment variables
source /opt/rh/devtoolset-7/enable
# Make sure that the executables and packages in the install cura-build-environment
# will be preferred.
export PATH="${CURA_BUILD_ENV_PATH}/bin:${PATH}"
export PKG_CONFIG_PATH="${CURA_BUILD_ENV_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
```

Note that the default entrypoint of this image is `/docker-entrypoint.sh`,
which executes the commands above.

# Building cura-build-environment on Native Machine

## Linux

Building on Linux is fairly straightforward:

```
cbe_src_dir=<where-your-source-dir-is>
cbe_install_dir=<where-you-want-to-install>

cd $cbe_src_dir
mkdir build
cd build

# Set some environment variables to make sure that the installed tools can be found.
export PATH=$cbe_install_dir/bin:$PATH
export PKG_CONFIG_PATH=$cbe_install_dir/lib/pkgconfig:$PKG_CONFIG_PATH

cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$cbe_install_dir \
      -DCMAKE_PREFIX_PATH=$cbe_install_dir \
      ..
make
```

Note that a fairly recent C++ compiler is required, at the very least GCC
4.9. If you are building on CentOS, you can get this from the devtoolset
packages.

## Mac OS

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
cbe_src_dir=<where-your-source-dir-is>
cbe_install_dir=<where-you-want-to-install>

cd $cbe_src_dir
mkdir build
cd build

source ../env_osx.sh

# Set some environment variables to make sure that the installed tools can be found.
export PATH=$cbe_install_dir/bin:$PATH
export PKG_CONFIG_PATH=$cbe_install_dir/lib/pkgconfig:$PKG_CONFIG_PATH

cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$cbe_install_dir \
      -DCMAKE_PREFIX_PATH=$cbe_install_dir \
      ..
make
```

## Windows



cura-build-environment on Windows requires Visual C++ 2015 (14.0) and MinGW-w64 
(version 4.9 or higher). Python and all Python modules are compiled with VC++
and CuraEngine is built with MinGW.

**Microsoft Visual Studio 2015 (Recommended)**
1. Download Microsoft Visual Studio from [here (Web Installer)](https://go.microsoft.com/fwlink/?LinkId=532606&clcid=0x409) or 
[here (ISO Image)](https://go.microsoft.com/fwlink/?LinkId=615448&clcid=0x409).
2. Run the installer. To save on space, Custom can be selected with only `Visual C++` selected in Programming Languages. The complete installation will be large (>12 GB) and will take a while to complete.

**MinGW-w64**
1. Download mingw-w64 from [here (executable installer)](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/mingw-w64-install.exe/download)
2. In the Settings page of the installer, select Architecture: i686 for 32bit or x86_64 for 64bit systems
3. Ensure that the directory C:\Program Files\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin (or the i686 equivalent) is in your PATH

The current cura-build-environment uses Python 3.5.2 which can be compiled with
Visual C++ 2015 (14.0) with Windows 8.1 SDK. Visual Studio 2017 doesn't seem to
be able to compile Python 3.5.* successfully.

In addition, Subversion is required for building Python (for building OpenSSL).
Please make sure all required tools are accessible through your path.

The `env_win32.bat` and `env_win64.bat` will make sure to set a few
environment variables that are required. Most importantly, they call the
`vcvarsall.bat` files from Visual C++ to ensure VC++ can be used.

To build, run the following:

```
set cbe_src_dir=<where-your-source-dir-is>
set cbe_install_dir=<where-you-want-to-install>

cd %cbe_src_dir%
mkdir build
cd build

..\env_win64.bat

cmake -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%cbe_install_dir% ^
      -DCMAKE_PREFIX_PATH=%cbe_install_dir% ^
      -G "NMake Makefiles" ^
      ..
nmake
```

Note: Using the NMake Makefiles generator is important, since the normal
Visual Studio generator does not work well in combination with some of
the build systems of the sub-projects that are built.
