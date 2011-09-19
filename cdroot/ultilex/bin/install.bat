@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParam

set /a counter=0
set /a error=0
set meta=..\temp\%1

REM ******************************
REM Check the meta structure BEGIN
REM ******************************
if not exist !meta!\meta goto corruptedMetaData
if not exist !meta!\includes.win goto corruptedMetaData
if not exist !meta!\includes.linux goto corruptedMetaData
if not exist !meta!\menu.cfg goto corruptedMetaData
if not exist !meta!\add.cfg goto corruptedMetaData
REM ****************************
REM Check the meta structure END
REM ****************************

for /f %%a in (!meta!\meta) do (
	if "!counter!"=="0" (
		set name=%%a
	)
	if "!counter!"=="1" (
		set dir=..\..\%%a
		if exist !dir! (
			set error=1
			goto errorLabel
		)
		mkdir !dir!
		mkdir !dir!\meta
		xcopy !meta! !dir!\meta\ /s /e
	)
	if "!counter!"=="2" (
		set newMD5=%%a
	)
	if "!counter!"=="3" (
		set url=%%a
		..\stuff\tools\WIN\wget\wget -O"..\temp\!name!.iso" !url!
		echo "Download complete"
		..\stuff\tools\WIN\7z\7z x ..\temp\!name!.iso -o..\temp\!name!
	)
	set /a counter+=1
)

set dest="NOTSET"
for /f %%a in (!meta!\includes.win) do (
	if !dest!=="NOTSET" (
		set source=%%a
		set dest="SET"
	) else (
		echo ..\temp\!name!\!source! !dir!%%a /s /e
		xcopy ..\temp\!name!\!source! !dir!%%a /s /e
		set dest="NOTSET"
	)
)

goto end

:missingParam
set error=2
goto :errorLabel

:corruptedMetaData
set error=3
goto :errorLabel

:errorLabel
echo.
if "!error!"=="1" echo ERROR: You have already installed '%1'.
if "!error!"=="2" echo ERROR: Required parameter is missing. Use 'dist-get help' for more information.
if "!error!"=="3" echo ERROR: Metadata is missing or corrupted. Use 'dist-get cleanup %1' and then 'dist-get prepare'.
echo.
goto end

:end
