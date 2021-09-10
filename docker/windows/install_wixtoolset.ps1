$tmpDir = "C:\temp-cura"
New-Item -Path $tmpDir -ItemType Directory -Force
Invoke-WebRequest -UseBasicParsing `
        -Uri https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip `
        -OutFile $tmpDir\wix.zip
( Get-FileHash -Algorithm SHA256 $tmpDir\wix.zip ).Hash -eq '2c1888d5d1dba377fc7fa14444cf556963747ff9a0a289a3599cf09da03b9e2e'
7z x $tmpDir\wix.zip -y -aoa -o"$tmpDir\wix"
ls $tmpDir
Move-Item $tmpDir\wix "C:\Program Files (x86)\wixtoolset"
Remove-Item -Recurse -Force -Path $tmpDir
