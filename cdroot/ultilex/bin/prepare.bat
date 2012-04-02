@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParameter

for /f %%v in ('getname %1') do set name=%%v

if not exist ..\..\!name! (
	mkdir ..\..\!name!
	mkdir ..\..\!name!\meta
	mkdir ..\..\!name!\temp
)

REM ***************************************
REM Downloads or copies the meta data BEGIN
REM ***************************************
if (%2)==(local) (
	copy %1 ..\..\!name!\temp\dist.zip
	goto unzip
) else (
..\stuff\tools\WIN\wget\wget -O"..\..\!name!\temp\dist.zip" %1
)
REM *************************************
REM Downloads or copies the meta data END
REM *************************************

:unzip
..\stuff\tools\WIN\7z\7z x ..\..\!name!\temp\dist.zip -o..\..\!name!\temp

:exit
del ..\..\!name!\temp\dist.zip
goto end

:missingParameter
echo.
call printerror missing_param
echo.
goto end

:end
