$tmpDir = "C:\temp-cura"
New-Item -Path $tmpDir -ItemType Directory -Force
Invoke-WebRequest -UseBasicParsing `
        -Uri https://github.com/wixtoolset/wix3/archive/wix3112rtm.zip `
        -OutFile $tmpDir\wix.zip
7z x -y -o$tmpDir\wix C:\temp-cura\wix.zip
Move-Item $tmpDir\wix "C:\Program Files (x86)\wixtoolset"
Remove-Item -Recurse -Force -Path $tmpDir
