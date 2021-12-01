REM This script install the Visual Studio 2019 build tools on a Windows Server Core 2019 (1809) docker image

REM Download the Build Tools bootstrapper and install them with the 
REM Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
curl -SL --output vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe  
vs_buildtools.exe --quiet --wait --norestart --nocache modify ^
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools" ^
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
    --add Microsoft.VisualStudio.Component.VC.CMake.Project ^
    --add Microsoft.VisualStudio.Component.Windows10SDK.19041 ^
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 ^
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 ^
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 ^
    --remove Microsoft.VisualStudio.Component.Windows81SDK ^
    || IF "%ERRORLEVEL%"=="3010" EXIT 0
REM Cleanup
del /q vs_buildtools.exe
