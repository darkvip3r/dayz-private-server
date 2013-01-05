@echo off
..\mysql -u root -p123456 --port 3310 dayz < 10_heli_fix.sql
..\mysql -u root -p123456 --port 3310 dayz < 20_procedures_navicat.sql
echo.
echo "Database Update 0.15 -> 0.17" > ..\..\..\xampp\v0.17.up
echo Database update completed! [0.17]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat