# cura-build-environment
CMake project to build dependencies for Cura

## Building on Linux

1. Installing dependencies:
  * python3 (>= 3.4.0)
  * python3-dev (>= 3.4.0)
  * python3-pyqt5 (>= 5.4.0)
  * python3-pyqt5.qtopengl (>= 5.4.0)
  * python3-pyqt5.qtquick (>= 5.4.0)
  * python3-pyqt5.qtsvg (>= 5.4.0)
  * python3-numpy (>= 1.8.0)
  * python3-serial (>= 2.6)
  * python3-opengl (>= 3.0)
  * python3-setuptools
  * python3-dev
  * qml-module-qtquick2 (>= 5.4.0)
  * qml-module-qtquick-window2 (>= 5.4.0)
  * qml-module-qtquick-layouts (>= 5.4.0)
  * qml-module-qtquick-dialogs (>= 5.4.0)
  * qml-module-qtquick-controls (>= 5.4.0)
  * libxcb1-dev
  * libx11-dev
  * zlib1g
  * build-essential
  * pkg-config
  * cmake
  * gfortran

  To build, make sure these dependencies are installed, then clone this repository and run the following commands from your clone:

  ```shell
  sudo apt-get install gfortran python3 python3-dev python3-pyqt5 python3-pyqt5.qtopengl python3-pyqt5.qtquick python3-pyqt5.qtsvg python3-numpy python3-serial python3-opengl python3-setuptools qml-module-qtquick2 qml-module-qtquick-window2 qml-module-qtquick-layouts qml-module-qtquick-dialogs qml-module-qtquick-controls gfortran pkg-config libxcb1-dev libx11-dev
  git clone http://github.com/Ultimaker/cura-build.git
  cd cura-build
  ```

2. Create a directory, where you want to build your dependencies, e.g. "build", and go into this diretory
  1. ```mkdir build```
  2. ```chdir build```
3. Now create another directory where all the installed dependencies go to, e.g. "inst".
  1. ```mkdir inst```
4. Finally configure your build, so the build dependencies will go into `inst`.
  1. ```cmake -DCMAKE_INSTALL_PREFIX=./inst ..```
5. Start your build via:
  1. ```make -j6```
