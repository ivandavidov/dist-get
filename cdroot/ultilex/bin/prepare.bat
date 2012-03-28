@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missingParameter

if not exist ..\temp mkdir ..\temp

if (%2)==(local) (
	copy %1 ..\temp\dist.zip
	goto unzip
) else (
..\stuff\tools\WIN\wget\wget -O"..\temp\dist.zip" %1
)

:unzip
..\stuff\tools\WIN\7z\7z x ..\temp\dist.zip -o..\temp\dist

for /f %%v in ('readproperty ..\temp\dist\meta name') do set name=%%v
for /f %%v in ('readproperty ..\temp\dist\meta installdir') do set installdir=%%v

if not exist ..\..\!installdir! (
	mkdir ..\..\!installdir!
	mkdir ..\..\!installdir!\meta
	REM TODO: mark that dist is not installed (IDEA: create an empty file (this file will contain the md5 of the current installed version))
)

:exit
ren ..\temp\dist !name!
xcopy ..\temp\!name! ..\..\!installdir!\meta\ /s /e /y
del ..\temp\dist.zip
rmdir /s /q ..\temp\!name!
goto end

:missingParameter
echo.
echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
echo.
goto end

:end
