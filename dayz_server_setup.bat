@echo off
COLOR 0B
set lang=%1

echo 1 - English
echo 2 - French
echo.
set /P lang=Choose your language: 
if "%lang%"=="1" cls & server_setup\dayz_server_setup_en.bat
if "%lang%"=="2" cls & server_setup\dayz_server_setup_fr.bat