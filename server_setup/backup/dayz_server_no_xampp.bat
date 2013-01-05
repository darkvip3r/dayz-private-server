@echo off
cd ..
if exist server_setup\perl\bin\perl.exe (goto dayzstart) else (dayz_server_setup.bat)

:dayzstart
server_setup\perl\bin\perl -w server_setup\vehicles.pl
"Expansion\beta\arma2oaserver.exe" -port=2302 "-config=Bliss\config.cfg" "-cfg=Bliss\basic.cfg" "-profiles=Bliss" -name=Bliss "-mod=@DayZ;@Bliss;" -cpuCount=2 -maxMem=1578
