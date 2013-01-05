@echo off
for %%i in (0.18\*sql) do if %%i neq 0.18\*sql if %%i neq 0.18\*sql if %%i neq 0.18\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.19\*sql) do if %%i neq 0.19\*sql if %%i neq 0.19\*sql if %%i neq 0.19\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.20\*sql) do if %%i neq 0.20\*sql if %%i neq 0.20\*sql if %%i neq 0.20\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.21\*sql) do if %%i neq 0.21\*sql if %%i neq 0.21\*sql if %%i neq 0.21\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.22\*sql) do if %%i neq 0.22\*sql if %%i neq 0.22\*sql if %%i neq 0.22\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.23\*sql) do if %%i neq 0.23\*sql if %%i neq 0.23\*sql if %%i neq 0.23\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.24\*sql) do if %%i neq 0.24\*sql if %%i neq 0.24\*sql if %%i neq 0.24\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.25\*sql) do if %%i neq 0.25\*sql if %%i neq 0.25\*sql if %%i neq 0.25\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.26\*sql) do if %%i neq 0.26\*sql if %%i neq 0.26\*sql if %%i neq 0.26\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (0.27\*sql) do if %%i neq 0.27\*sql if %%i neq 0.27\*sql if %%i neq 0.27\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (extra\BlissBuildings\0.01\*sql) do if %%i neq extra\BlissBuildings\0.01\*sql if %%i neq extra\BlissBuildings\0.01\*sql if %%i neq extra\BlissBuildings\0.01\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (extra\BlissInvCust\0.01\*sql) do if %%i neq extra\BlissInvCust\0.01\*sql if %%i neq extra\BlissInvCust\0.01\*sql if %%i neq extra\BlissInvCust\0.01\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i
for %%i in (extra\BlissMessaging\0.01\*sql) do if %%i neq extra\BlissMessaging\0.01\*sql if %%i neq extra\BlissMessaging\0.01\*sql if %%i neq extra\BlissMessaging\0.01\*sql echo %%i & ..\mysql -u root --password=123456 -h 127.0.0.1 --port=3310 --database=dayz < %%i

echo.
echo "Database Update 0.17 -> 0.27" > ..\..\..\xampp\v0.27.up
echo Database update completed! [0.27]
echo Please press any key to restart the server.
pause
cd ..\..\..\..\ & dayz_server.bat