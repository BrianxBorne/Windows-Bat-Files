@echo off
echo Press Enter to shut down or Esc to quit.

for /f "delims=" %%I in ('powershell -noprofile -command ^
    "$k = $host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); if ($k.VirtualKeyCode -eq 13) { 'Enter' } elseif ($k.VirtualKeyCode -eq 27) { 'Esc' }"') do set "key=%%I"

if /i "%key%"=="Enter" (
    shutdown.exe -s -t 0
) else if /i "%key%"=="Esc" (
    exit
)
