@echo off
..\mysql -u root -p123456 --port 3310 dayz < 10_spawns_heli.sql
..\mysql -u root -p123456 --port 3310 dayz < 20_proc_fix_navicat.sql
echo.
echo "Database Update 0.13 -> 0.14" > ..\..\..\xampp\v0.14.up
echo Database update completed! [0.14]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat