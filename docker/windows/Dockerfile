FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

LABEL windows_version="1809" \
      architecture="amd64" \
      vs_version="2019" \
      windows_sdk_version="10" \
      python_version="3.10.4" \
      qt_version="6.2.4"

COPY install_vs2019_buildtools.cmd install_wixtools.ps1 C:\\Temp

# Install chocolatey
RUN powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
	iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Enable global confirmation
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    choco feature enable -n=allowGlobalConfirmation

# Install other build tools
#  - perl, svn, and nasm are needed by OpenSSL for Python
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    choco install -y 7zip; \
    choco install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'; \
    choco install -y git --params '/GitOnlyOnPath /NoAutoCrlf /SChannel'; \
    choco install -y nsis; \
    choco install -y strawberryperl; \
    choco install -y tortoisesvn; \
    choco install -y nasm; \
    choco install -y doxygen.install; \
    choco install -y poedit

# Install Visual Studio buildtools
RUN C:\\Temp\\src\\docker\\windows\\install_vs2019_buildtools.cmd

# Get WiX Toolset 3.11.2
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    C:\\Temp\\src\\docker\\windows\\install_wixtoolset.ps1

# Set up environment variables.
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    C:\\Temp\\src\\docker\\windows\\setup_envvars.ps1

# Cleanup
RUN powershell.exe -NoLogo -ExecutionPolicy Bypass -Command \
    Remove-Item -Recurse -Force C:\\Temp\\

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
