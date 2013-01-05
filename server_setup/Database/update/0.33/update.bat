@echo off
for %%i in (*sql) do if %%i neq *sql if %%i neq *sql if %%i neq *sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.31\*sql) do if %%i neq 0.31\*sql if %%i neq 0.31\*sql if %%i neq 0.31\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.32\*sql) do if %%i neq 0.32\*sql if %%i neq 0.32\*sql if %%i neq 0.32\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.33\*sql) do if %%i neq 0.33\*sql if %%i neq 0.33\*sql if %%i neq 0.33\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i

echo.
echo "Database Update 0.30.1 -> 0.33" > ..\..\..\xampp\v0.33.up
echo Database update completed! [0.33]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat