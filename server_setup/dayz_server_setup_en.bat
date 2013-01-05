@echo off
COLOR 0B
set instance=%1
set core=%2
set clean=%3
set drive=%4
set time=%5
set menu=%6
set vehicles=%7
set reinstall=%8
set lanmode=%9
set lmenu=%10
set lingor_reinstall=%11
set reset_menu=%12
set vmenu=%13
set cmenu=%14
set amenu=%15

echo #########################################################################
echo #                                                                       #
echo #         Welcome in DayZ Bliss Private Server installation.            #
echo #     This little script will help you to start up a DayZ server.       #
echo #       If you have any trouble, please report on Tunngle forum.        #
echo #                                                                       #
echo #                                        Installer created by Darkvip3r #
echo #########################################################################
echo.

:installer_check
if exist server_setup\perl\bin\perl.exe (goto checkupdate) else (goto perl)
if exist server_setup\xampp\xampp_start.exe (goto checkupdate) else (goto xampp)

:instance
cls
echo Choose your instance ID for this server (1-999...)
set /P instance=Instance ID: 
echo.
echo How many CPU cores you wanna use for the server? (recommended: 2+)
set /P core=CPU core(s): 
echo.
echo Maximum number of the vehicles? (0-52)
set /P vehicles=Number: 

del MPMissions\DayZAbdul_%instance%.Chernarus.pbo
@start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini
cls
echo "Please wait...Loading"
ping -n 15 127.0.0.1>nul
 
server_setup\BatchSubstitute.bat "vechiclesnumber" %vehicles% server_setup\vehicles.pl>vehicles.pl & server_setup\BatchSubstitute.bat "123" %instance% server_setup\sql\instance.sql>server_setup\sql\instance_%instance%.sql & server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\instance_%instance%.sql & taskkill /IM mysqld.exe /F & server_setup\BatchSubstitute.bat "instanceid" %instance% server_setup\config.cfg>Bliss\config.cfg & server_setup\BatchSubstitute.bat "vehicles.pl 123" "vehicles.pl %instance%" server_setup\server.cfg>server_setup\server_core.bak & server_setup\BatchSubstitute.bat "corenumber" %core% server_setup\server_core.bak>dayz_server.bat & server_setup\BatchSubstitute.bat "123" %instance% server_setup\init.cfg>server_setup\DayZAbdul.Chernarus\init.sqf & server_setup\cpbo.exe -p server_setup\DayZAbdul.Chernarus MPMissions\DayZAbdul_%instance%.Chernarus.pbo & del server_setup\*.bak & pause & start dayz_server_setup.bat

:perl
echo Looks like this is the first time that you run the installation.
echo If you are ready to install, press any key to continue. (1GB free space required)
pause
cls
echo Do you want to install xampp? Warning!! only for people who understand Xampp. just press cancel and use the intergrated xampp
xampp\xampp-win32-1.8.1-VC9-installer.exe
echo Installing .NET Framework 4.0... (if you already have, just click on Cancel)
server_setup\tools\dotNetFx40_Full_setup.exe
echo.
echo Installing the latest supported Arma 2 Beta patch... 
server_setup\patch\ARMA2_OA_Build_99113.exe
echo.
echo Applying vehicles fix. Please select YES.
server_setup\vehicle_fix.reg
server_setup\rar.exe x server_setup\perl.rar server_setup\ & cls & if exist server_setup\xampp\xampp_start.exe (goto checkupdate) else (goto xampp)

:xampp
server_setup\rar.exe x server_setup\xampp.rar server_setup\ & cls & goto checkupdate

:menu
cls
echo Welcome to Easy Server Setup menu. 
echo.
echo ArmA 2 settings
echo ---------------
echo 1 - Change your ArmA 2 and OA CD keys
echo 2 - Download the latest ArmA 2 Beta patches
echo.
echo S - Start DayZ mod launcher
echo.
echo DayZ server settings
echo --------------------
echo 3 - Vehicle menu
echo 4 - If you don't see any vehicles, select this to fix it
echo 5 - Fix "Invalid/Banned CD key" problem on your cracked server
echo 6 - Edit servers config.cfg file
echo.
echo 7 - BlissAdmin menu
echo.
echo 0 - Reinstall the server
REM echo R - Reset characters
echo U - Update BattlEye script file
echo.
set /P menu=Select a number or lettter: 
if "%menu%"=="0" goto reinstall
if "%menu%"=="U" cd server_setup & start update_scripts.bat & cls & goto menu
if "%menu%"=="u" cd server_setup & start update_scripts.bat & cls & goto menu
REM if "%menu%"=="R" goto reset_char
REM if "%menu%"=="r" goto reset_char
if "%menu%"=="1" start server_setup\arma2_keygen.exe & server_setup\cdkey_changer.bat & goto menu
if "%menu%"=="3" goto vehicles_menu_xampp
if "%menu%"=="2" start http://www.arma2.com/beta-patch.php & cls & goto menu
REM if "%menu%"=="2" cls & echo Please wait... & server_setup\patch\ARMA2_OA_Build_99113.exe & goto menu
if "%menu%"=="4" goto fix_vehicles
if "%menu%"=="5" goto badkey
if "%menu%"=="6" goto configs
if "%menu%"=="7" goto blissadmin_menu
if "%menu%"=="S" start dayz_game.bat & exit
if "%menu%"=="s" start dayz_game.bat & exit

:reinstall
cls
echo Are you sure you want to reinstall the DayZ Server?
echo.
echo 1 - Yes
echo 2 - No
echo.
set /P reinstall=Choose a number: 
if "%reinstall%"=="1" taskkill /IM mysql.exe /F & taskkill /IM mysqld.exe /F  & RD /S /Q server_setup\xampp & goto xampp
if "%reinstall%"=="2" goto menu

:lanmode
cls
echo You can switch between Online / LAN mode
echo.
echo 1 - Online (BattlEye=on)
echo 2 - Online (No CDKEY, BattlEye=off)
echo 3 - LAN (Tunngle, BattlEye=on)
echo.
set /P lanmode=Select a number: 
if "%lanmode%"=="1" server_setup\BatchSubstitute.bat "127.0.0.1" "arma2oapc.master.gamespy.com" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "BattlEye" "//off_BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu
if "%lanmode%"=="2" server_setup\BatchSubstitute.bat "127.0.0.1" "arma2oapc.master.gamespy.com" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "//off_BattlEye" "BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu
if "%lanmode%"=="3" server_setup\BatchSubstitute.bat "arma2oapc.master.gamespy.com" "127.0.0.1" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "BattlEye" "//off_BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu

:clean
cls
echo Are you sure you want to clean the instance_vehicle database?
echo.
echo 1 - Yes
echo 2 - No
echo.
set /P clean=Choose a number: 
if "%clean%"=="1" server_setup\xampp\mysql\bin\mysql.exe -u root -p123456 --port 3310 dayz < server_setup\sql\clean.sql & echo instance_vehicle table cleaned! & pause & goto menu
if "%clean%"=="2" goto vehicles_menu

:badkey
cls
echo To fix "Invalid CD key" problem, you need to block 
echo UDP 29910 outbound port in your Firewall software.
echo.
echo 29910 - Key server
echo.
echo If you use Windows Firewall in Windows 7, just press any key to open the 
echo Firewall manager.
pause
echo.
echo What is the Windows partition? (C, D, E, etc...)
set /P drive=Select the partition: 
mmc %drive%:\Windows\system32\wf.msc
cls
goto menu

:reset_char
cls
echo Do you want to reset all characters?
echo.
echo 1 - Yes
echo 2 - No
echo.
set /P reset_menu=Choose a number: 
if "%reset_menu%"=="1" goto reset_char_yes
if "%reset_menu%"=="2" goto menu

:reset_char_yes
cls
taskkill /IM arma2oaserver.exe /F &
@start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini
cls
echo "Please wait...Loading"
ping -n 10 127.0.0.1>nul
server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\clean_main.sql
del server_setup\sql\backup\dayz.sql
del server_setup\sql\backup\lingor.sql
cls
echo.
echo Character reset completed.
Echo If you see some missing file error, don't worry about it.
echo.
pause
goto menu

:removed
cls
echo.
echo The server starter and instance generator has been removed.
echo I might add a new function here later.
echo.
pause
goto menu

:vehicles
cls
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
set /P instance=Instance number: 
set /P vehicles=Maximum number of the vehicles? (0-52): 

server_setup\perl\bin\perl -w server_setup\bliss_files\db_spawn_vehicles.pl --instance %instance% --port 3310 --pass 123456 --limit %vehicles%
echo.
pause
goto vehicles_menu

:fix_vehicles
cls
echo Applying vehicles fix. Please select YES.
server_setup\vehicle_fix.reg
echo.
echo Vehicles fix installed.
pause
goto menu

:checkupdate
if exist server_setup\xampp\v0.35.up (goto menu) else (goto checkfailed)

:checkfailed
echo Looks like some database update are available.
echo Please run the dayz_server.bat first.
pause
exit

:vehicles_menu_xampp
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="0" goto vehicles_menu
if "%ERRORLEVEL%"=="1" @start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini & echo "Please wait...Loading" & ping -n 10 127.0.0.1>nul & goto vehicles_menu

:vehicles_menu
cls
echo 0 - Back to main menu
echo.
echo 1 - Show the spawned vehicles (Currently not working)
echo 2 - Spawn/respawn random vehicles
echo 3 - Clean the spawned vehicles table
echo.
set /P vmenu=Select a number or lettter: 
if "%vmenu%"=="0" goto menu
if "%vmenu%"=="1" goto show_vehicle
if "%vmenu%"=="2" goto vehicles
if "%vmenu%"=="3" goto clean

:show_vehicle
cls
REM start server_setup\vehicle_ids.html
REM echo Opening vehicles IDs list in your browser.
REM echo Currently spawned vehicles (IDs):
REM server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\show_vehicles.sql
REM echo.
REM echo If you don't see anything above this line, that means you don't have spawned vehicle.
REM echo.
REM pause
goto vehicles_menu

:configs
cls
echo 0 - Back to main menu
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
set /P cmenu=Instance number: 
if "%cmenu%"=="0" goto menu
if "%cmenu%"=="1" server_setup\notepad\notepad++.exe dayz_1.chernarus\config.cfg & goto configs
if "%cmenu%"=="2" server_setup\notepad\notepad++.exe dayz_2.lingor\config.cfg & goto configs
if "%cmenu%"=="3" server_setup\notepad\notepad++.exe dayz_3.utes\config.cfg & goto configs
if "%cmenu%"=="4" server_setup\notepad\notepad++.exe dayz_4.takistan\config.cfg & goto configs
if "%cmenu%"=="5" server_setup\notepad\notepad++.exe dayz_5.panthera2\config.cfg & goto configs
if "%cmenu%"=="6" server_setup\notepad\notepad++.exe dayz_6.fallujah\config.cfg & goto configs
if "%cmenu%"=="7" server_setup\notepad\notepad++.exe dayz_7.zargabad\config.cfg & goto configs
if "%cmenu%"=="8" server_setup\notepad\notepad++.exe dayz_8.namalsk\config.cfg & goto configs
if "%cmenu%"=="9" server_setup\notepad\notepad++.exe dayz_9.mbg_celle2\config.cfg & goto configs
if "%cmenu%"=="10" server_setup\notepad\notepad++.exe dayz_10.tavi\config.cfg & goto configs

:blissadmin_menu
cls
echo You need to download the BlissAdmin first, then start the Apache server.
echo Check the config file and change the rcon password to your rcon pass.
echo.
echo Server page: http://youriphwere - insert your server IP here
echo Admin page: http://127.0.0.1/admin.php
echo Default admin login: admin/123456
echo.
echo 0 - Back to the main menu
echo 1 - Start Apache HTTP server
echo.
echo 2 - Download/update UnclearWall's BlissAdmin
echo 3 - Edit BlissAdmin settings
echo.
set /P amenu=Select a number: 
if "%amenu%"=="0" goto menu
if "%amenu%"=="1" goto blissadmin_1
if "%amenu%"=="2" goto blissadmin_2
if "%amenu%"=="3" goto blissadmin_3

:blissadmin_1
cls
tasklist /FI "IMAGENAME eq httpd_usbwv8.exe" 2>NUL | find /I /N "httpd_usbwv8">NUL
if "%ERRORLEVEL%"=="0" echo Apache HTTP server already running! & pause & goto blissadmin_menu
if "%ERRORLEVEL%"=="1" goto blissadmin_1.1

:blissadmin_1.1
cls
if exist server_setup\admin\usbwebserver.exe (goto blissadmin_1.2) else (echo Please download the BlissAdmin first! & pause & goto blissadmin_menu)

:blissadmin_1.2
cd server_setup\admin\
start usbwebserver.exe
cd ..\..\ 
goto blissadmin_menu

:blissadmin_2
cls
if exist server_setup\admin\installer.bat (goto blissadmin_2.1) else (server_setup\rar.exe x server_setup\admin.rar server_setup\ & cls & goto blissadmin_2.1)

:blissadmin_2.1
cd server_setup\admin\
start installer.bat
cd ..\..\
goto blissadmin_menu

:blissadmin_3
cls
if exist server_setup\admin\root\config.php (goto blissadmin_3.1) else (echo Please download the BlissAdmin first! & pause & goto blissadmin_menu)

:blissadmin_3.1
cls
server_setup\notepad\notepad++.exe server_setup\admin\root\config.php 
goto blissadmin_menu