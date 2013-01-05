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

echo #########################################################################
echo #                                                                       #
echo #     Bienvenue dans l'installation de serveur prive DayZ Bliss.        #
echo #       Ce script va vous aider a demarrer votre serveur DayZ.          #
echo #                    Si vous rencontre un probleme,                     #
echo #              merci de le rapporter sur le forum Tunngle.              #
echo #                                                                       #
echo #                                         Installeur cree par ConanHUN  #
echo #########################################################################
echo.

:installer_check
if exist server_setup\perl\bin\perl.exe (goto checkupdate) else (goto perl)
if exist server_setup\xampp\xampp_start.exe (goto checkupdate) else (goto xampp)

:instance
cls
echo Choisissez l'ID de votre instance pour ce serveur (1-999...)
set /P instance=ID de l'Instance : 
echo.
echo Combien de coeurs CPU voulez-vous utiliser pour ce serveur ? (recommande : 2+)
set /P core=coeur(s) CPU : 
echo.
echo Nombre maximum de vehicules ? (0-52)
set /P vehicles=Nombre : 

del MPMissions\DayZAbdul_%instance%.Chernarus.pbo
@start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini
cls
echo "Merci de patienter...Chargement"
ping -n 15 127.0.0.1>nul
 
server_setup\BatchSubstitute.bat "vechiclesnumber" %vehicles% server_setup\vehicles.pl>vehicles.pl & server_setup\BatchSubstitute.bat "123" %instance% server_setup\sql\instance.sql>server_setup\sql\instance_%instance%.sql & server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\instance_%instance%.sql & taskkill /IM mysqld.exe /F & server_setup\BatchSubstitute.bat "instanceid" %instance% server_setup\config.cfg>Bliss\config.cfg & server_setup\BatchSubstitute.bat "vehicles.pl 123" "vehicles.pl %instance%" server_setup\server.cfg>server_setup\server_core.bak & server_setup\BatchSubstitute.bat "corenumber" %core% server_setup\server_core.bak>dayz_server.bat & server_setup\BatchSubstitute.bat "123" %instance% server_setup\init.cfg>server_setup\DayZAbdul.Chernarus\init.sqf & server_setup\cpbo.exe -p server_setup\DayZAbdul.Chernarus MPMissions\DayZAbdul_%instance%.Chernarus.pbo & del server_setup\*.bak & pause & start dayz_server_setup.bat

:perl
echo Il semblerait que c'est la premiere fois que vous lancez l'installation
echo Si vous etes pret, appuyez sur n'importe quelle touche pour continuer (1Go d'espace disque sera necessaire)
pause
cls
echo Installation de .NET Framework 4.0... (Si vous l'avez deja, appuyez sur Annuler)
server_setup\tools\dotNetFx40_Full_setup.exe
echo.
echo Installation du dernier patch Beta supporte d'ArmA 2... 
server_setup\patch\ARMA2_OA_Build_99113.exe
echo.
echo Application de la correction des vehicules. Merci de selectionner OUI.
server_setup\vehicle_fix.reg
server_setup\rar.exe x server_setup\perl.rar server_setup\ & cls & if exist server_setup\xampp\xampp_start.exe (goto checkupdate) else (goto xampp)

:xampp
server_setup\rar.exe x server_setup\xampp.rar server_setup\ & cls & goto checkupdate

:menu
cls
echo Bienvenue dans le menu de Easy Server Setup. 
echo.
echo Parametres ArmA 2
echo -----------------
echo 1 - Changer les cles CD de ArmA 2 et OA
echo 2 - Telecharger le dernier des patch Beta d'ArmA 2
echo.
echo S - Demarrer le lanceur de DayZ mod
echo.
echo Parametres du serveur DayZ
echo --------------------------
echo 3 - Menu des vehicles
echo 4 - Si vous ne voyez aucun vehicules, selectionner ce menu pour les corriger
echo 5 - Corriger le probleme de "Cle CD invalide/bannie" sur votre serveur craque
echo 6 - Modifier le fichier config.cfg de vos serveurs
echo.
echo 7 - BlissAdmin menu
eco.
echo 0 - Reinstaller le serveur
REM echo R - Reinitialiser les personnages
echo U - Mettre a jour le fichier de script BattlEye
echo.
set /P menu=Choisissez un chiffre ou une lettre : 
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
echo ?tes-vous sur de vouloir reinstaller le serveur DayZ ?
echo.
echo 1 - Oui
echo 2 - Non
echo.
set /P reinstall=Choisissez un chiffre : 
if "%reinstall%"=="1" taskkill /IM mysql.exe /F & taskkill /IM mysqld.exe /F  & RD /S /Q server_setup\xampp & goto xampp
if "%reinstall%"=="2" goto menu

:lanmode
cls
echo Vous pouvez changer entre les modes En ligne / LAN
echo.
echo 1 - En ligne (BattlEye=on)
echo 2 - En ligne (Pas de cle CD, BattlEye=off)
echo 3 - LAN (Tunngle, BattlEye=on)
echo.
set /P lanmode=Choisissez un chiffre : 
if "%lanmode%"=="1" server_setup\BatchSubstitute.bat "127.0.0.1" "arma2oapc.master.gamespy.com" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "BattlEye" "//off_BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu
if "%lanmode%"=="2" server_setup\BatchSubstitute.bat "127.0.0.1" "arma2oapc.master.gamespy.com" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "//off_BattlEye" "BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu
if "%lanmode%"=="3" server_setup\BatchSubstitute.bat "arma2oapc.master.gamespy.com" "127.0.0.1" Bliss\config.cfg>Bliss\config2.cfg & server_setup\BatchSubstitute.bat "BattlEye" "//off_BattlEye" Bliss\config2.cfg>Bliss\config.cfg & del Bliss\config2.cfg & goto menu

:clean
cls
echo ?tes-vous sur de vouloir nettoyer la table instance_vehicle de votre base de donnees ?
echo.
echo 1 - Oui
echo 2 - Non
echo.
set /P clean=Choisissez un chiffre : 
if "%clean%"=="1" server_setup\xampp\mysql\bin\mysql.exe -u root -p123456 --port 3310 dayz < server_setup\sql\clean.sql & echo instance_vehicle table cleaned! & pause & goto menu
if "%clean%"=="2" goto vehicles_menu

:badkey
cls
echo Pour corriger le probleme de "Cle CD invalide/bannie", vous devez bloquer
echo le port UDP sortant 29910 avec votre par-feu.
echo.
echo 29910 - Serveur cle
echo.
echo Si vous utilisez le par-feu Windows de Windows 7, appuyez sur n'importe
echo quelle touche pour ouvrir le gestionnaire du par-feu.
pause
echo.
echo Quelle est la partition de Windows ? (C, D, E, etc...)
set /P drive=Choisissez la partition : 
mmc %drive%:\Windows\system32\wf.msc
cls
goto menu

:reset_char
cls
echo Voulez-vous reinitialiser tous les personnages ?
echo.
echo 1 - Oui
echo 2 - Non
echo.
set /P reset_menu=Choisissez un chiffre : 
if "%reset_menu%"=="1" goto reset_char_yes
if "%reset_menu%"=="2" goto menu

:reset_char_yes
cls
taskkill /IM arma2oaserver.exe /F &
@start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini
cls
echo "Merci de patienter...Chargement"
ping -n 10 127.0.0.1>nul
server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\clean_main.sql
del server_setup\sql\backup\dayz.sql
del server_setup\sql\backup\lingor.sql
cls
echo.
echo Reinitialisation des personnages terminee.
Echo Si vous avez des erreurs de fichiers manquants, ne vous en preoccupez pas.
echo.
pause
goto menu

:removed
cls
echo.
echo Le lanceur de serveur et le generateur d'instances ont ete supprimes.
echo J'ajouterai une nouvelle fonctionnalite peut-etre plus tard.
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
set /P instance=Numero de l'instance : 
set /P vehicles=Nombre maximum de vehicules ? (0-52) : 

server_setup\perl\bin\perl -w server_setup\bliss_files\db_spawn_vehicles.pl --instance %instance% --port 3310 --pass 123456 --limit %vehicles%
echo.
pause
goto vehicles_menu

:fix_vehicles
cls
echo Application des corrections des vehicules. Merci de choisir Oui.
server_setup\vehicle_fix.reg
echo.
echo Corrections des vehicules installees.
pause
goto menu

:checkupdate
if exist server_setup\xampp\v0.35.up (goto menu) else (goto checkfailed)

:checkfailed
echo Des mises a jour de la base de donnees semblent etre disponibles.
echo Merci de d'abord lancer le fichier dayz_server_setup.bat
pause
exit

:vehicles_menu_xampp
cls
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if "%ERRORLEVEL%"=="0" goto vehicles_menu
if "%ERRORLEVEL%"=="1" @start server_setup\silentcmd server_setup\xampp\mysql\bin\mysqld.exe --defaults-file=server_setup\xampp\mysql\bin\my.ini & echo "Merci de patienter...Chargement" & ping -n 10 127.0.0.1>nul & goto vehicles_menu

:vehicles_menu
cls
echo 0 - Retour au menu principal
echo.
echo 1 - Afficher les vehicules generes (Ne fonctionne pas actuellement)
echo 2 - Generer/Regenerer des vehicules aleatoirement
echo 3 - Nettoyer la table des vehicules generes
echo.
set /P vmenu=Choisissez un chiffre ou une lettre: 
if "%vmenu%"=="0" goto menu
if "%vmenu%"=="1" goto show_vehicle
if "%vmenu%"=="2" goto vehicles
if "%vmenu%"=="3" goto clean

:show_vehicle
cls
REM start server_setup\vehicle_ids.html
REM echo Ouverture des ID des vehicules dans votre navigateur.
REM echo Vehicules actuellement generes (IDs):
REM server_setup\xampp\mysql\bin\mysql.exe -u dayz -p123456 --port 3310 dayz < server_setup\sql\show_vehicles.sql
REM echo.
REM echo Si vous ne voyez rien au-dessus de cette ligne, cela signifie que vous n'avez aucun vehicule genere.
REM echo.
REM pause
goto vehicles_menu

:configs
cls
echo 0 - Retour au menu principal
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
set /P cmenu=Numero d'instance : 
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