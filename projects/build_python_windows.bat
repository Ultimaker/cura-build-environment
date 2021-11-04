@echo off
setlocal enableextensions
rem Custom Python installation script, because Python itself lacks one.

%* "/p:PlatformToolset=v142" "/p:DefaultWindowsSDKVersion=10"
