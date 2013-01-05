@echo off
mkdir ..\@Bliss\addons
mkdir ..\@BlissLingor\addons
mkdir ..\MPMissions
util\cpbo.exe -y -p bliss\dayz_server ..\@Bliss\addons\dayz_server.pbo
util\cpbo.exe -y -p bliss\dayz_lingor ..\@BlissLingor\addons\dayz_server.pbo
util\cpbo.exe -y -p bliss\missions\dayz.lingor ..\MPMissions\dayz.lingor.pbo
util\cpbo.exe -y -p bliss\missions\dayz.chernarus ..\MPMissions\dayz.chernarus.pbo
