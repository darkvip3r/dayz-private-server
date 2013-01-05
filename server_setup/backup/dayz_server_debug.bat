@echo off
cd ..
if exist server_setup\perl\bin\perl.exe (goto mysql) else (dayz_server_setup.bat)

:mysql
if exist server_setup\xampp\mysql\bin\mysql.exe (goto dayzstart) else (dayz_server_setup.bat)

:dayzstart
taskkill /IM mysql.exe /F &
taskkill /IM mysqld.exe /F &
taskkill /IM arma2oaserver.exe /F &
@start server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini
cls
echo "Please wait...Loading"
ping -n 10 127.0.0.1>nul
if exist server_setup\xampp\v2.2.up (goto update2.2.1) else (cd db_update\v2.2\ & start update.bat)

:update2.2.1
if exist server_setup\xampp\v2.2.1.up (goto start) else (cd db_update\v2.2.1\ & start update.bat)

:start
server_setup\perl\bin\perl -w server_setup\vehicles.pl
"Expansion\beta\arma2oaserver.exe" -port=2302 "-config=Bliss\config.cfg" "-cfg=Bliss\basic.cfg" "-profiles=Bliss" -name=Bliss "-mod=@DayZ;@Bliss;" -cpuCount=1 -maxMem=1578
cd server_setup\xampp & mysql_stop.bat
