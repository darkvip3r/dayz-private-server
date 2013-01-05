@echo off
..\mysql -u root -p123456 --port 3310 dayz < 2_1to2_2.sql
echo.
echo "Database Update 2.2 -> 2.2.1" > ..\..\server_setup\xampp\v2.2.1.up
echo Database update completed! [v2.2.1]
echo Please press any key to restart the server.
pause
cd ..\..\ & dayz_server.bat
