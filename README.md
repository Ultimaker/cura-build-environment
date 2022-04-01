# cura-build-environment

**WIP**

This repository contains helper scripts for building Cura from source. It will create a base environment from which
you can (re)build Cura on a regular basis, in an time efficient matter. It consists of the following tools.

## System Requirements

- Python 3.10.2
- conan >= 1.46

### Linux
- GCC >= 8.0
- CMake >= 3.16
- GNU Make >= 4
- Docker >= 20

### MacOS
- MacOS SDK 
- clang-apple
- MacOS

### Windows
- Visual Studio >= 16
- NMake
- Docker

## CMake script

The CMake project will ensure that the following dependencies are build and can be installed in a location for future
use.  It will download and install the following projects:

- libnest2d
- pynest2d
- libsavitar
- libarcus
- Python dependencies
  - wheel
  - cython
  - pybind11
  - pytest
  - more-itertools
  - wcwidth
  - pluggy
  - attrs
  - py
  - atomicwrites
  - colorama
  - packaging
  - pyparsing
  - six
  - pytest-benchmark
  - py-cpuinfo
  - pytest-cov
  - coverage
  - tomli
  - mypy-extensions
  - typing-extensions
  - typed-ast
  - mypy
  - cffi
  - pycparser
  - cryptography
  - sys_platform
  - cryptography
  - sys_platform
  - cryptography
  - sys_platform
  - toml
  - sip
  - pyinstaller
  - altgraph
  - pyinstaller-hooks-contrib
  - pefile
  - macholib
  - appdirs
  - certifi
  - chardet
  - decorator
  - idna
  - netifaces
  - networkx
  - numpy-stl
  - pycollada
  - PyQt6-sip
  - PyQt6
  - PyQt6-Qt6
  - pyserial
  - python-dateutil
  - python-utils
  - requests
  - sentry-sdk
  - trimesh
  - urllib3
  - importlib-metadata
  - zipp
  - jeepney
  - SecretStorage
  - keyring
  - Twisted
  - constantly
  - hyperlink
  - incremental
  - zope.interface
  - Automat
  - twisted-iocpsupport
  - zeroconf
  - ifaddr
  - numpy
  - scipy
  - pyclipper
  - lxml
  - pywin32
  - pywin32-ctypes
  - cx-Logging

The list of dependencies above also have their own dependencies, such as:

- cpython
- protobuf
- clipper
- boost
- gtest
- nlopt

These can be installed with the help of [Conan](https://conan.io/), which is a dependency manager for C++ projects.
It will either download the binaries and header files or compile it automatically from source. It will also generate
the CMake find_package modules, such that these can be used. The `conanfile.txt` located in the root of this directory
specifies a list of used dependencies.

Installation of Conan is simple:

```bash
pip install conan
```

> Ultimaker has its own standard Conan configuration, you could apply these with the command below. Keep in mind that
> this isn't necesarry and it might overwrite your current Conan configuration
> ```bash
> conan config install https://github.com/ultimaker/conan-config.git
> ```


Once Conan is installed and configured, installing the cura-build-environment is easy. The steps below should do the
trick.

```bash
mkdir build && cd build
conan install .. --build=missing
cmake -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_PREFIX_PATH=<install_path> -DCMAKE_INSTALL_PREFIX=<install_path>
. activate_run.sh
cmake --build .
cmake --install .
```
_For more detailed explanation and options see the [Conan online documentation](https://docs.conan.io/en/latest/)._

The `<install_path>` should now contain all used dependencies which can be used by the
[cura-build](https://github.com/Ultimaker/cura-build) repository.

# Recommended usage with Docker image

This repository also contains dockerfiles which will build a cura-builder image for either Windows or Linux. These images
contain all build essentials to both build cura-build-environment and cura-build

## Linux

Build the docker file
```bash
cd docker/linux
docker build -t cura-build-env:<branch_name> -f Dockerfile .
```

This docker image can be used to create a cura-builder which helps us build the cura-build and cura-build-environment.

First we need to create a build environment
```bash
DOCKER_BUILDKIT=1 docker build --build-arg JFROG_PASSWORD=JmZofe2*EjvoN=?9=4 -f Dockerfile -t cura-build-env 
docker run -v /mnt/projects/ultimaker/cura/cura-build-environment:/home/ultimaker/source -v /mnt/projects/ultimaker/cura/cura-build-environment/cmake-build-release-docker/:/home/ultimaker/build -v /mnt/projects/ultimaker/cura/cura-build-environment/install/:/home/ultimaker/install -v /home/peer23peer/.conan/data:/home/ultimaker/.conan/data --name blerker cura-env-builder:latest 
```

```bash
docker create -t cura-env-builder:<branch_name \
-v <source_path_cura-build-environment>:/home/ultimaker/source \
-v <build_path_cura-build-environment>:/home/ultimaker/build \
-v <install_path_cura-build-environment>:/home/ultimaker/install \
-v ~/.conan/data:/home/ultimaker/.conan/data cura-build-env:<branch_name>
```
> NOTE:
> By specifying the conan data folder we ensure that big dependencies, such as Python
> and Boost can be used in multiple environments and are reused when we are recreating
> the environment from scratch.

We can then build the environment with:
```bash
cd <root_cura_build_environment>
docker run cura-env-builder:cura-8640 \
-DLIBNEST2D_BRANCH_OR_TAG=<branch> \
-DCMAKE_......
```

Once the environment is build and installed in the path `<install_path_cura-build-environment>` we can then check out
the cura-build repository and build Cura using the cura-builder and the previously build cura-build-environment.

```bash
docker create -t cura-builder:<branch_name \
-v <source_path_cura-build-environment>:/home/ultimaker/source \
-v <build_path_cura-build-environment>:/home/ultimaker/build \
-v <install_path_cura-build-environment>:/home/ultimaker/install \
-v <install_path_cura-build-environment>:/home/ultimaker/env \
-v ~/.conan/data:/home/ultimaker/.conan/data cura-build-env:<branch_name
```
Notice the extra volume, which contains the previous build environment

We can then build Cura with:
```bash
cd <root_cura_build>
docker run cura-builder:cura-8640 \
-DURANIUM_BRANCH_OR_TAG=<branch> \
-DCMAKE_......
```