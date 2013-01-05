@echo off
for %%i in (*sql) do if %%i neq *sql if %%i neq *sql if %%i neq *sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
echo.
echo "Database Update 0.30 -> 0.30.1" > ..\..\..\xampp\v0.30.1.up
echo Database update completed! [0.30.1]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat