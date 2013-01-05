@echo off
COLOR 0B
set server=%1

cd ..
if exist server_setup\perl\bin\perl.exe (goto mysql) else (dayz_server_setup.bat)

:mysql
if exist server_setup\xampp\mysql\bin\mysql.exe (goto database) else (dayz_server_setup.bat)

:database
if exist server_setup\xampp\v0.13.up (goto database_2) else (start server_setup\reinstall.bat & goto exit)

:database_2
if exist server_setup\xampp\v0.35.up (goto start) else (goto dayzstart)

:dayzstart
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="0" goto update0.14
if "%ERRORLEVEL%"=="1" @start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini & echo "Please wait...Loading" & ping -n 10 127.0.0.1>nul & goto update0.14

:update0.14
if exist server_setup\xampp\v0.14.up (goto update0.15) else (cd server_setup\Database\update\0.14\ & start update.bat & exit)

:update0.15
if exist server_setup\xampp\v0.15.up (goto update0.17) else (cd server_setup\Database\update\0.15\ & start update.bat & exit)

:update0.17
if exist server_setup\xampp\v0.17.up (goto update0.27) else (cd server_setup\Database\update\0.17\ & start update.bat & exit)

:update0.27
if exist server_setup\xampp\v0.27.up (goto update0.28) else (cd server_setup\Database\update\0.27\ & start update.bat & exit)

:update0.28
if exist server_setup\xampp\v0.28.up (goto update0.28_1) else (cd server_setup\Database\update\0.28\ & start update.bat & exit)

:update0.28_1
if exist server_setup\xampp\v0.28_1.up (goto update0.29) else (cd server_setup\Database\update\0.28_1\ & start update.bat & exit)

:update0.29
if exist server_setup\xampp\v0.29.up (goto update0.30) else (cd server_setup\Database\update\0.29\ & start update.bat & exit)

:update0.30
if exist server_setup\xampp\v0.30.up (goto update0.30.1) else (cd server_setup\Database\update\0.30\ & start update.bat & exit)

:update0.30.1
if exist server_setup\xampp\v0.30.1.up (goto update0.33) else (cd server_setup\Database\update\0.30.1\ & start update.bat & exit)

:update0.33
if exist server_setup\xampp\v0.33.up (goto update0.35) else (cd server_setup\Database\update\0.33\ & start update.bat & exit)

:update0.35
if exist server_setup\xampp\v0.35.up (goto start) else (cd server_setup\Database\update\0.35\ & start update.bat & exit)

:start
cls
echo 0 - Start MySQL server
echo X - Stop MySQL server
echo.
echo 1  - Chernarus
echo 2  - Lingor Island
echo 3  - Utes
echo 4  - Takistan
echo 5  - Panthera
echo 6  - Fallujah
echo 7  - Zargabad
echo 8  - Namalsk
echo 9  - Celle
echo 10 - Taviana
echo.
set /P menu=Choose what server you want to run: 
if "%menu%"=="1" goto chernarus
if "%menu%"=="2" goto lingor
if "%menu%"=="3" goto utes
if "%menu%"=="4" goto takistan
if "%menu%"=="5" goto panthera
if "%menu%"=="6" goto fallujah
if "%menu%"=="7" goto zargabad
if "%menu%"=="8" goto namalsk
if "%menu%"=="9" goto celle
if "%menu%"=="10" goto taviana
if "%menu%"=="0" goto mysql_start
if "%menu%"=="x" goto mysql_stop
if "%menu%"=="X" goto mysql_stop

:chernarus
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_chernarus_1.bat & goto start

:lingor
cls
if exist @dayzlingor\addons\dayz.pbo (goto lingor_start) else (goto check_fail)

:lingor_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_lingor_2.bat & goto start

:utes
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_utes_3.bat & goto start

:takistan
cls
if exist @dayztakistan\addons\dayz.pbo (goto takistan_start) else (goto check_fail)

:takistan_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_takistan_4.bat & goto start

:panthera
cls
if exist @dayzpanthera\addons\dayz.pbo (goto panthera_start) else (goto check_fail)

:panthera_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_panthera2_5.bat & goto start

:fallujah
cls
if exist @dayzfallujah\addons\dayz.pbo (goto fallujah_start) else (goto check_fail)

:fallujah_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_fallujah_6.bat & goto start

:zargabad
cls
if exist @dayzzargabad\addons\dayz.pbo (goto zargabad_start) else (goto check_fail)

:zargabad_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_zargabad_7.bat & goto start

:namalsk
cls
if exist @dayz_namalsk\addons\dayz.pbo (goto namalsk_start) else (goto check_fail)

:namalsk_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_namalsk_8.bat & goto start

:celle
cls
if exist @dayz_celle\addons\dayz.pbo (goto celle_start) else (goto check_fail)

:celle_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_mbg_celle2_9.bat & goto start

:taviana
cls
if exist @dayztaviana\addons\dayz.pbo (goto taviana_start) else (goto check_fail)

:taviana_start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="1" echo Start the MySQL server first! & pause
start server_setup\silentcmd server_setup\server_tavi_10.bat & goto start

:mysql_Start
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="0" echo MySQL server already running! & pause
if "%ERRORLEVEL%"=="1" @start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini & echo "Please wait...Loading" & ping -n 10 127.0.0.1>nul
goto start

:mysql_stop
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="0" @start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqladmin.exe -u root -p123456 --port=3310 shutdown & echo MySQL server shutting down. & ping -n 5 127.0.0.1>nul
if "%ERRORLEVEL%"=="1" echo MySQL server is not running! & pause
goto start

:check_fail
cls
echo Please download this map, before you start the server.
echo Use the DayZ Commander to download the latest maps.
pause
goto start