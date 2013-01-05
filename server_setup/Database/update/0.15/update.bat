@echo off
..\mysql -u root -p123456 --port 3310 dayz < 10_spawns_uaz_fix.sql
..\mysql -u root -p123456 --port 3310 dayz < 11_spawns_desc.sql
echo.
echo "Database Update 0.14 -> 0.15" > ..\..\..\xampp\v0.15.up
echo Database update completed! [0.15]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat