# cura-build-environment
CMake project to build dependencies for Cura

## Building dependencies on Linux

1. Create a directory, where you want to build your dependencies, e.g. "build", and go into this diretory
  1. ```mkdir build```
  2. ```chdir build```
2. Now create another directory where all the installed dependencies go to, e.g. "inst".
  1. ```mkdir inst```
3. Finally configure your build, so the build dependencies will go into `inst`.
  1. ```cmake -DCMAKE_INSTALL_PREFIX=./inst ..```
4. Start your build via:
  1. ```make -j6```
