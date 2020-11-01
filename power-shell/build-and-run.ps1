if (Test-Path Build) {
    Remove-Item "Build" -Recurse    
}
Compress-Archive -Path .\* -DestinationPath .\Game -Force
mkdir "Build"
mkdir "Build\BuildCache"
Copy-Item -Path "Game.zip" -Destination "Build\BuildCache\Game.zip"
Rename-Item -Path "Game.zip" "Game.love"
Move-Item -Path "Game.love" -Destination "Build"
Copy-Item -Path "C:\Program Files\LOVE\love.exe" -Destination "Build"
cmd /c copy /b Build\love.exe+Build\Game.love Build\Game.exe
Move-Item -Path "Build\Game.love" -Destination "Build\BuildCache"
Move-Item -Path "Build\Love.exe" -Destination "Build\BuildCache"
Build\Game.exe