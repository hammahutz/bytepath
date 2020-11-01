#Make directory Build
if (Test-Path "build") {
    Remove-Item "build" -Recurse    
}
New-Item "build" -ItemType "directory"
New-Item "build\build-cache" -ItemType "directory"

#Make game cahce files
Compress-Archive -Path "source\*" -DestinationPath "build\build-cache\Game" -Force
Copy-Item -Path "C:\Program Files\LOVE\love.exe" -Destination "build\build-cache\"
Copy-Item -Path "build\build-cache\Game.zip" -Destination "build\build-cache\Game.love"

#Make .exe file
cmd /c copy /b build\build-cache\love.exe+build\build-cache\Game.love build\Game.exe
Rename-Item "build\Game.exe" ((Get-Content "game-config\config.json" | ConvertFrom-Json | select -expand "game-name" +) + ".exe")
./build/*.exe