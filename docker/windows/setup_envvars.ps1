# Set up environment variables for the cura-build-environment docker image.

# chocolatey doesn't seem to add NSIS to PATH, so we add it here.
[Environment]::SetEnvironmentVariable("Path", "C:\Program Files (x86)\NSIS;$env:Path", [System.EnvironmentVariableTarget]::Machine)

# Set Cura build environment variables.
[Environment]::SetEnvironmentVariable("CURA_BUILD_ENV_BUILD_TYPE", "$env:CURA_BUILD_ENV_BUILD_TYPE", [System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("CURA_BUILD_ENV_PATH", "$env:CURA_BUILD_ENV_PATH", [System.EnvironmentVariableTarget]::Machine)
