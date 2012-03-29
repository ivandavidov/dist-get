@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParameter

if not exist ..\temp mkdir ..\temp

REM ***************************************
REM Downloads or copies the meta data BEGIN
REM ***************************************
if (%2)==(local) (
	copy %1 ..\temp\dist.zip
	goto unzip
) else (
..\stuff\tools\WIN\wget\wget -O"..\temp\dist.zip" %1
)
REM *************************************
REM Downloads or copies the meta data END
REM *************************************

:unzip
..\stuff\tools\WIN\7z\7z x ..\temp\dist.zip -o..\temp\dist

for /f %%v in ('readproperty ..\temp\dist\meta name') do set name=%%v

if not exist ..\..\!name! (
	mkdir ..\..\!name!
	mkdir ..\..\!name!\meta
	mkdir ..\..\!name!\temp
)

:exit
ren ..\temp\dist !name!
xcopy ..\temp\!name! ..\..\!name!\temp\ /s /e /y
del ..\temp\dist.zip
rmdir /s /q ..\temp
goto end

:missingParameter
echo.
echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
echo.
goto end

:end
