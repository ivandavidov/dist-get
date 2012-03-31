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
echo.
call printerror mising_param
echo.

goto end

:corruptedMetaData
echo.
call printerror corrupted_meta_data %1
echo.

goto end

:mismatchName
echo.
call printerror mismatch_name %1
echo.

goto end

:alreadyInstalled
echo.
call printerror already_installed %1
echo.

:end
