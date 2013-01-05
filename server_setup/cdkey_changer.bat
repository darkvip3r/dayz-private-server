@echo off
::Autor: ConanHUN

set lang=1


:inicio
if exist SimpleShutdownTimer.exe del /f/q SimpleShutdownTimer.exe >nul
if "%lang%"=="1" goto english
if "%lang%"=="2" goto spanish
SET lang=0
cls
echo.
echo.
echo.
echo   1. English
echo   2. Espa¤ol
echo.
set /p lang=Select your language / Elija su idioma (1/2): 
if %lang%==1 goto english
if %lang%==2 goto spanish
goto inicio

:english
goto change_key
exit

:change_key
if exist "%commonprogramfiles(x86)%" (
	FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\Software\Wow6432Node\Bohemia Interactive Studio\ArmA 2" /v KEY 2^>nul') DO SET arma2key=%%B
	FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\Software\Wow6432Node\Bohemia Interactive Studio\ArmA 2 OA" /v KEY 2^>nul') DO SET arma2OAkey=%%B
) else (
	FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\Software\Bohemia Interactive Studio\ArmA 2" /v KEY 2^>nul') DO SET arma2key=%%B
	FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKLM\Software\Bohemia Interactive Studio\ArmA 2 OA" /v KEY 2^>nul') DO SET arma2OAkey=%%B
)
SET elegir_serial=99
cls
echo.
if "%lang%"=="1" (
	if "%arma2key%"=="" (
		echo There is not ArmA 2 key installed. You must install one.
	) else (
		echo Current ArmA 2 key: %arma2key%
	)
	if "%arma2OAkey%"=="" (
		echo There is not ArmA 2 OA key installed. You must install one.
	) else (
		echo Current ArmA 2 OA key: %arma2OAkey%
	)	
	echo.
	echo.
	echo Generate ArmA 2 and ArmA 2: OA key with the keygen
	echo and copy here the LOWER SERIALS WITHOUT SPACE!
	echo.
	goto custom_serial
)
goto inicio

:custom_serial
echo.
if "%lang%"=="1" (
	SET /P arma2key=Type 30 digits to use as ArmA 2 serial number: 
	SET /P arma2OAkey=Type 30 digits to use as OA serial number: 
) else (
	SET /P arma2key=Entre 30 d¡gitos a usar como serial del ArmA 2: 
	SET /P arma2OAkey=Entre 30 d¡gitos a usar como serial del OA: 
)
if "%arma2key%"=="" (
	if "%arma2OAkey%"=="" goto inicio
) 

:nuevo_serial
if exist "%commonprogramfiles(x86)%" (
	if not "%arma2key%"=="" REG ADD "HKLM\Software\Wow6432Node\Bohemia Interactive Studio\ArmA 2" /f /v KEY /t REG_BINARY /d "%arma2key%"
	if not "%arma2OAkey%"=="" REG ADD "HKLM\Software\Wow6432Node\Bohemia Interactive Studio\ArmA 2 OA" /f /v KEY /t REG_BINARY /d "%arma2OAkey%"
) else (
	if not "%arma2key%"=="" REG ADD "HKLM\Software\Bohemia Interactive Studio\ArmA 2" /v KEY /t REG_BINARY /d "%arma2key%"
	if not "%arma2OAkey%"=="" REG ADD "HKLM\Software\Bohemia Interactive Studio\ArmA 2 OA" /v KEY /t REG_BINARY /d "%arma2OAkey%"
)
goto end

:dedi_server
cls
echo.
echo.
if "%lang%"=="1" (
	echo Possibilities:
	echo.
	echo   1. ArmA 2 dedicated server.
	echo   2. ArmA 2 OA dedicated server.
	echo   3. Use a tool.
	echo.
	echo.
	SET /P elegir_herramienta=Type the number of your option: 
) else (
	echo Posibilidades:
	echo.
	echo   1. Servidor dedicado ArmA 2.
	echo   2. Servidor dedicado ArmA 2 OA.
	echo   3. Usar una herramienta.
	echo.
	echo.
	SET /P elegir_herramienta=Escriba el n£mero de su elecci¢n: 
)

if "%elegir_herramienta%"=="1" (
	if exist arma2server.exe (
		start arma2server.exe
		exit
	) else (
		cls
		echo.
		echo.
		if "%lang%"=="1" (
			echo Error: "arma2server.exe" not found.
		) else echo Error: "arma2server.exe" no encontrado.
		echo.
		echo.
		pause
		goto inicio
	)
) else (
	if "%elegir_herramienta%"=="2" (
		if exist arma2oaserver.exe (
			start arma2oaserver.exe
			exit
		) else (
			cls
			echo.
			echo.
			if "%lang%"=="1" (
				echo Error: "arma2oaserver.exe" not found.
			) else echo Error: "arma2oaserver.exe" no encontrado.
			echo.
			echo.
			pause
			goto inicio
		)
	) else (
		if "%elegir_herramienta%"=="3" (
			if exist TA2DST.exe (
				start TA2DST.exe
				exit			
			) else (
				cls
				echo.
				echo.
				if "%lang%"=="1" (
					echo Error: "TA2DST.exe" not found.
				) else echo Error: "TA2DST.exe" no encontrado.
				echo.
				echo.
				pause
				goto inicio
			)
		)
	)
)
goto inicio

:comenzar
if exist arma2oa.exe (
	cls
	echo.
	echo.
	if "%lang%"=="1" (
		echo Remember:
		echo.
		echo  1. You must launch VirtualCD and mount the mini-image "NS-A2OA_SR-poseden.vc4"
		echo  to the PHYSICAL DVD, NOT TO THE VIRTUAL ONE.
		echo.
		echo  2. If you want to use the LAN multiplayer, each computer must have a different
		echo  serial number installed. Change it with the last option of the main menu.
	) else (
		echo Recuerde que:
		echo.
		echo  1. Con el VirtualCD debe tener montada la mini-imagen "NS-A2OA_SR-poseden.vc4"
		echo  en la unidad de DVD F¡SICA, NO EN LA VIRTUAL.
		echo.
		echo  2. Para jugar en LAN los distintos terminales han de usar diferentes n£meros
		echo  de serie, que se pueden cambiar con la £ltima opci¢n del men£ principal.
	)
	echo.
	echo.
	pause
	start arma2oa.exe
	exit
) else (
	if exist arma2.exe (
		cls
		echo.
		echo.
		if "%lang%"=="1" (
			echo Remember:
			echo.
			echo  1. You must launch VirtualCD and mount the mini-image "NS-A2OA_SR-poseden.vc4"
			echo  to the PHYSICAL DVD, NOT TO THE VIRTUAL ONE.
			echo.
			echo  2. If you want to use the LAN multiplayer, each computer must have a different
			echo  serial number installed. Change it with the last option of the main menu.
		) else (
			echo Recuerde que:
			echo.
			echo  1. Con el VirtualCD debe tener montada la mini-imagen "NS-A2OA_SR-poseden.vc4"
			echo  en la unidad de DVD F¡SICA, NO EN LA VIRTUAL.
			echo.
			echo  2. Para jugar en LAN los distintos terminales han de usar diferentes n£meros
			echo  de serie, que se pueden cambiar con la £ltima opci¢n del men£ principal.
		)
		echo.
		echo.
		pause
		start arma2.exe
		exit
	) else (
		cls
		echo.
		echo.
		if "%lang%"=="1" (
			echo Error: neither "arma2oa.exe" nor "arma2.exe" found.
		) else echo Error: ni "arma2oa.exe" ni "arma2.exe" encontrados.
		echo.
		echo.
		pause
		goto inicio
	)
)
:end
echo New key successfully installed
pause