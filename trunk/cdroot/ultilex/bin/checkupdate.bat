@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParameter

REM ******************************
REM Check the meta structure BEGIN
REM ******************************
if not exist ..\..\%1\meta goto corruptedOldMetaData
if not exist ..\..\%1\includes.win goto corruptedOldMetaData
if not exist ..\..\%1\includes.linux goto corruptedOldMetaData
if not exist ..\..\%1\menu.cfg goto corruptedOldMetaData
if not exist ..\..\%1\add.cfg goto corruptedOldMetaData

if not exist ..\temp\%1\meta goto corruptedNewMetaData
if not exist ..\temp\%1\includes.win goto corruptedNewMetaData
if not exist ..\temp\%1\includes.linux goto corruptedNewMetaData
if not exist ..\temp\%1\menu.cfg goto corruptedNewMetaData
if not exist ..\temp\%1\add.cfg goto corruptedNewMetaData
REM ****************************
REM Check the meta structure END
REM ****************************

set /a counter=0
set oldMeta=..\..\%1\meta
set newMeta=..\temp\%1

for /f %%a in (!oldMeta!\meta) do (
	if "!counter!"=="2" (
		set oldMD5=%%a
	)
	set /a counter+=1
)

set /a counter=0

for /f %%a in (!newMeta!\meta) do (
	if "!counter!"=="2" (
		set newMD5=%%a
	)
	set /a counter+=1
)

if !newMD5!==!oldMD5! (
	echo 0 > temp_eq.tmp
) else (
	echo 1 > temp_neq.tmp
)

:corruptedOldMetaData
echo.
echo ERROR: Metadata information for '%1' is corrupted or missing. Cannot continue.
echo.
goto end

:corruptedNewMetaData
echo.
echo ERROR: New metadata for '%1' is corrupted or missing. Use 'dist-get prepare' to fix the issue.
echo.
goto end

:missingParameter
echo.
echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
echo.
goto end

:end