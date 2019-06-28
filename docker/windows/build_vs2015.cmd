REM This script builds the cura-build-environment with a Windows Server Core >= 2016 (1607) docker image.

@echo OFF

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64

set PATH=C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin;%PATH%
set PATH=%CURA_BUILD_ENV_PATH%\bin;%PATH%

cd %CURA_BUILD_ENV_WORK_DIR%
mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH="%CURA_BUILD_ENV_PATH%" ^
      -DCMAKE_INSTALL_PREFIX="%CURA_BUILD_ENV_PATH%" ^
      -DBUILD_OS_WIN64=ON ^
      -DCURA_ARCUS_BRANCH_OR_TAG="%ARCUS_BRANCH_OR_TAG%" ^
      -DCURA_SAVITAR_BRANCH_OR_TAG="%SAVITAR_BRANCH_OR_TAG%" ^
      -G "NMake Makefiles" ^
      ..\src
nmake
