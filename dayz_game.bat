@echo off
COLOR 0B
set mod=%1

echo DayZ mod launcher.
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
set /P mod=Mod number: 
if "%mod%"=="1" start Expansion\beta\arma2oa.exe -mod=@Dayz -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="2" start Expansion\beta\arma2oa.exe -mod=@dayzlingor -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="3" start Expansion\beta\arma2oa.exe -mod=@dayz -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="4" start Expansion\beta\arma2oa.exe -mod=@dayztakistan -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="5" start Expansion\beta\arma2oa.exe -mod=@dayzpanthera -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="6" start Expansion\beta\arma2oa.exe -mod=@dayzfallujah -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="7" start Expansion\beta\arma2oa.exe -mod=@dayzzargabad -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="8" start Expansion\beta\arma2oa.exe -mod=@dayz;@dayz_namalsk -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="9" start Expansion\beta\arma2oa.exe -mod=@mbg_celle2;@dayz_celle -beta=Expansion\beta;Expansion\beta\Expansion -nosplash
if "%mod%"=="10" start Expansion\beta\arma2oa.exe -mod=@dayztaviana -beta=Expansion\beta;Expansion\beta\Expansion -nosplash

exit

