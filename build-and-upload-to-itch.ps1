# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
# powershell.exe -File .\build-and-upload-to-itch.ps1

Start-Process -Wait Godot_v4.4.1-stable_win64.exe '--headless --export-debug "Web" "..\..\export\web\index.html"'
7z a  ..\..\export\web.zip ..\..\export\web\*
butler.exe push ..\..\export\web.zip namespacev/slavic2025:web
