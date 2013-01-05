@echo off
for %%i in (*sql) do if %%i neq *sql if %%i neq *sql if %%i neq *sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.34\*sql) do if %%i neq 0.34\*sql if %%i neq 0.34\*sql if %%i neq 0.34\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.35\*sql) do if %%i neq 0.35\*sql if %%i neq 0.35\*sql if %%i neq 0.35\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i

echo.
echo "Database Update 0.33 -> 0.35" > ..\..\..\xampp\v0.35.up
echo Database update completed! [0.35]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat