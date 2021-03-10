@echo off
setlocal enableextensions
rem Custom Python installation script, because Python itself lacks one.

%* "/p:PlatformToolset=v140" "/p:DefaultWindowsSDKVersion=8.1"
