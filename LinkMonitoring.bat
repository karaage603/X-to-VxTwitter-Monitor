@echo off
setlocal EnableDelayedExpansion

:monitor
rem Get clipboard contents 
for /f "usebackq delims=" %%I in (`powershell -sta "add-type -as System.Windows.Forms; [windows.forms.clipboard]::GetText()"`) do set "clipboard_content=%%I"

rem Set string to search for 
set "search_string=https://x.com"

rem Set string to replace with
set "replace_string=https://vxtwitter.com"

echo !clipboard_content! | findstr /C:"!search_string!" >nul

if !errorlevel! equ 0 (

rem Modify clipboard content 
    set "modified_content=!clipboard_content:%search_string%=%replace_string%!"

rem Copy modified string to clip.exe
    echo !modified_content! | clip
)

rem Wait for 5 seconds before looping
timeout /t 5 > nul
goto :monitor
