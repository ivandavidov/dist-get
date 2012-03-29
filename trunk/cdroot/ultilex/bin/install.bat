@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParam

set /a error=0
set temp=..\..\%1\temp
set dir=..\..\%1

REM ******************************
REM Check the meta structure BEGIN
REM ******************************
if not exist %temp%\meta goto corruptedMetaData
if not exist %temp%\includes goto corruptedMetaData
if not exist %temp%\menu.cfg goto corruptedMetaData
if not exist %temp%\add.cfg goto corruptedMetaData
REM ****************************
REM Check the meta structure END
REM ****************************

REM ********************
REM Load meta data BEGIN
REM ********************
for /f %%v in ('readproperty !temp!\meta name') do set name=%%v
for /f %%v in ('readproperty !temp!\meta md5') do set newMD5=%%v
for /f %%v in ('readproperty !temp!\meta url') do set url=%%v
REM ******************
REM Load meta data END
REM ******************

REM **********************
REM Checks meta data BEGIN
REM **********************
if not !name!==%1 goto mismatchName
if exist %dir%\meta\meta goto alreadyInstalled
if exist %dir%\meta\includes goto alreadyInstalled
if exist %dir%\meta\menu.cfg goto alreadyInstalled
if exist %dir%\meta\add.cfg goto alreadyInstalled
xcopy !temp! !dir!\meta /s /e
REM ********************
REM Checks meta data END
REM ********************

REM ******************************************
REM Downloads or copies the distribution BEGIN
REM ******************************************
if "%2" == "" (
	..\stuff\tools\WIN\wget\wget -O !temp!\!name!.iso !url!
	echo Download complete.
) else (
	copy %2 !temp!\!name!.iso
)
REM ****************************************
REM Downloads or copies the distribution END
REM ****************************************

..\stuff\tools\WIN\7z\7z x !temp!\!name!.iso -o!temp!\!name!

REM ********************************
REM Copies the necessary files BEGIN
REM ********************************
set dest="NOTSET"
for /f %%a in ('..\stuff\tools\WIN\properties\sed "s/|/\\/g" !temp!\includes') do (
	if !dest!=="NOTSET" (
		set source=%%a
		set dest="SET"
	) else (
		echo !temp!\!name!\!source! !dir!%%a /s /e
		xcopy !temp!\!name!\!source! !dir!%%a /s /e
		set dest="NOTSET"
	)
)
REM ******************************
REM Copies the necessary files END
REM ******************************

goto end

:missingParam
set error=2
goto errorLabel

:corruptedMetaData
set error=3
goto errorLabel

:mismatchName
set error=4
goto errorLabel

:alreadyInstalled
set error=5
goto errorLabel

:errorLabel
echo.
if "!error!"=="1" echo ERROR: You have already installed '%1'.
if "!error!"=="2" echo ERROR: Required parameter is missing. Use 'dist-get help' for more information.
if "!error!"=="3" echo ERROR: Metadata is missing or corrupted. Use 'dist-get cleanup %1' and then 'dist-get prepare'.
if "!error!"=="4" echo ERROR: This meta data is not for this distribution.
if "!error!"=="5" echo ERROR: This distribution is already installed.
echo.
goto end

:end
