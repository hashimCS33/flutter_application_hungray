# Start Android Emulator safely - kills stale processes first
Write-Output "Cleaning up stale emulator processes..."

# Kill all emulator and QEMU processes
Get-Process | Where-Object { $_.Name -like "*qemu*" -or $_.Name -like "*emulator*" } |
    Stop-Process -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 2

# Reset ADB
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb" kill-server
Start-Sleep -Seconds 1
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb" start-server

Write-Output "Starting Pixel_6_API_34 emulator..."
& "$env:LOCALAPPDATA\Android\Sdk\emulator\emulator" -avd Pixel_6_API_34 -no-snapshot-load `
    -memory 1536 -cores 2 -no-audio -no-boot-anim -gpu swiftshader_indirect
