@echo off
cd ..
if exist server_setup\perl\bin\perl.exe (goto dayzstart) else (dayz_server_setup.bat)

:dayzstart
"Expansion\beta\arma2oaserver.exe" -port=2302 "-config=Bliss\config.cfg" "-cfg=Bliss\basic.cfg" "-profiles=Bliss" -name=Bliss "-mod=@DayZ;@Bliss;" -noPause -noSound -cpuCount=2 -exThreads=1 -maxMem=2048
