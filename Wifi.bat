@echo off
cls

:: Display ASCII art from lines between ::ascii and ::endascii labels
setlocal enabledelayedexpansion
set "print="

for /f "usebackq delims=" %%A in ("%~f0") do (
    if "%%A"=="::ascii" (
        set "print=1"
        rem skip this line
    ) else if "%%A"=="::endascii" (
        set "print="
    ) else (
        if defined print echo %%A
    )
)
endlocal

echo.

:: Get connected Wi-Fi SSID
for /f "tokens=2 delims=:" %%A in ('netsh wlan show interfaces ^| findstr "SSID" ^| findstr /v "BSSID"') do (
    set ssid=%%A
)

:: Trim leading space from SSID
set ssid=%ssid:~1%

:: Get Wi-Fi password for that SSID
for /f "tokens=2 delims=:" %%B in ('netsh wlan show profile name^="%ssid%" key^=clear ^| findstr "Key Content"') do (
    set password=%%B
)

:: Trim leading space from password
set password=%password:~1%

:: Display Wi-Fi info
echo Wi-Fi Name    : %ssid%
echo Wi-Fi Password: %password%
echo.

pause
goto :eof

::ascii
           ___
        .';:;'.
       /_' _' /\   __
       ;a/ e= J/-'"  '.
       \ ~_   (  -'  ( ;_ ,.
        L~"'_.    -.  \ ./  )
        ,'-' '-._  _;  )'   (
      .' .'   _.'")  \  \(  | @Bornelabs bat files 
     /  (  .-'   __\{`', \  |  www.bornelabs.tech
    / .'  /  _.-'   "  ; /  |     Wifi-Gollumn
   / /    '-._'-,     / / \ (
 __/ (_    ,;' .-'    / /  /_'-._
`"-'` ~`  ccc.'   __.','     \j\L\
                 .='/|\7      
     ' `
::endascii
