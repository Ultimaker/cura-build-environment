@echo off
setlocal enableextensions
rem Custom Python installation script, because Python itself lacks one.

set SCRIPTDIR=%~dp0

set ARCH=%~1
set SOURCEDIR=%~f2
set DESTDIR=%~f3

echo arch %ARCH%
echo source %SOURCEDIR%
echo dest %DESTDIR%

if not defined ARCH goto :help
if not defined SOURCEDIR goto :help
if not defined DESTDIR goto :help

if "%ARCH%"=="win32" (
    goto :install
) else (
    if "%ARCH%"=="amd64" (
        goto :install
    )
)
goto :invalid_arch

:install

set BINDIR=%SOURCEDIR%\PCbuild\%ARCH%

echo bindir %BINDIR%

echo Install binaries to DESTDIR/bin

mkdir %DESTDIR%\bin

echo %BINDIR%\python.exe

copy /Y %BINDIR%\python.exe %DESTDIR%\bin
copy /Y %BINDIR%\*.dll %DESTDIR%\bin

echo Install libraries to DESTDIR/lib

mkdir %DESTDIR%\lib

copy /Y %BINDIR%\*.pyd %DESTDIR%\lib

xcopy /Y /E %SOURCEDIR%\lib\* %DESTDIR%\lib

echo Install import libraries to DESTDIR/libs

mkdir %DESTDIR%\libs

copy /Y %BINDIR%\*.lib %DESTDIR%\libs

echo Install headers into DESTDIR/include

mkdir %DESTDIR%\include

xcopy /Y /E %SOURCEDIR%\include\* %DESTDIR%\include

copy /Y %SOURCEDIR%\PC\pyconfig.h %DESTDIR%\include

exit /B 0

:invalid_arch

echo Invalid architecture. Options are win32 or amd64.
echo.

:help

echo Usage: install_python_windows.bat [arch] [source dir] [dest dir]
echo.
echo  [arch]       Architecture to install. Either win32 or amd64.
echo  [source dir] Source directory. Should be root of the Python source.
echo  [dest dir]   Destination directory. Will be cleaned before installation.
