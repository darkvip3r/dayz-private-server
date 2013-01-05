@echo off
for %%i in (*sql) do if %%i neq *sql if %%i neq *sql if %%i neq *sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
echo.
echo "Database Update 0.28_1 -> 0.29" > ..\..\..\xampp\v0.29.up
echo Database update completed! [0.29]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat