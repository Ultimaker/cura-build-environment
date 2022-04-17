# cura-build-environment

**WIP**

This repository contains helper scripts for building Cura from source. It will create a base environment from which
which are used to build an installer for the specific OS.

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
- makensis (should be on the PATH)
- jinja2 (should be parth of Conan)

## CMake script

The CMake project will ensure that the following dependencies are build and can be installed in a location for future
use.  It will download and install the following projects:

- libnest2d
- pynest2d
- libsavitar
- libarcus
- Python dependencies
  - Automat
  - PyQt6
  - PyQt6-NetworkAuth
  - PyQt6-NetworkAuth-Qt6
  - PyQt6-Qt6
  - PyQt6-sip
  - SecretStorage
  - Twisted
  - altgraph
  - appdirs
  - atomicwrites
  - attrs
  - certifi
  - cffi
  - chardet
  - colorama
  - constantly
  - coverage
  - cryptography
  - cx-Logging
  - cython
  - decorator
  - future
  - hyperlink
  - idna
  - ifaddr
  - importlib-metadata
  - incremental
  - jeepney
  - keyring
  - lxml
  - macholib
  - more-itertools
  - mypy
  - mypy-extensions
  - netifaces
  - networkx
  - numpy
  - numpy-stl
  - packaging
  - pefile
  - pluggy
  - py
  - py-cpuinfo
  - pybind11
  - pyclipper
  - pycollada
  - pycparser
  - pyinstaller
  - pyinstaller-hooks-contrib
  - pyparsing
  - pyserial
  - pytest
  - pytest-benchmark
  - pytest-cov
  - python-dateutil
  - python-utils
  - pywin32
  - pywin32-ctypes
  - requests
  - scipy
  - sentry-sdk
  - setuptools
  - sip
  - six
  - sys_platform
  - toml
  - tomli
  - trimesh
  - twisted-iocpsupport
  - typed-ast
  - typing-extensions
  - urllib3
  - wcwidth
  - wheel
  - zeroconf
  - zipp
  - zope.interface

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
conan profile new default --detect
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
cmake -DCMAKE_PREFIX_PATH=<install_path> -DCMAKE_INSTALL_PREFIX=<install_path> ..
cmake --build .
```

The Installer for your OS can now be found in the `<install_path>/installer/dist/`

> On Windows make sure you are working in the x64 Visual Studio 2019/2022 Command Prompt and specify the NMake generator using the
> `cmake -G "NMake Makefiles" -DCMAKE_PREFIX_PATH=<install_path> -DCMAKE_INSTALL_PREFIX=<install_path> ..`

> If you want to see all the options available use a tool such as `ccmake` or `cmake-gui` 
