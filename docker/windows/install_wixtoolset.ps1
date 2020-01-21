$tmpDir = "C:\temp-cura"
New-Item -Path $tmpDir -ItemType Directory -Force
Invoke-WebRequest -UseBasicParsing `
        -Uri https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip `
        -OutFile $tmpDir\wix.zip
7z x $tmpDir\wix.zip -y -aoa -o"$tmpDir\wix"
ls $tmpDir
Move-Item $tmpDir\wix "C:\Program Files (x86)\wixtoolset"
Remove-Item -Recurse -Force -Path $tmpDir
