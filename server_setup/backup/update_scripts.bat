@echo off
cd ..\Bliss\BattlEye
..\..\server_setup\util\wget.exe --quiet -N http://dayz-community-banlist.googlecode.com/git/filters/scripts.txt
echo Updated scripts.txt
..\..\server_setup\util\wget.exe --quiet -N http://dayz-community-banlist.googlecode.com/git/filters/remoteexec.txt
echo Updated remoteexec.txt
..\..\server_setup\util\wget.exe --quiet -N http://dayz-community-banlist.googlecode.com/git/filters/createvehicle.txt
echo Updated createvehicle.txt
