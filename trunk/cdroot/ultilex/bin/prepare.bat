@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

mkdir ..\temp

if a_%2==a_local (
	copy %1 ..\temp\dist.zip
	goto unzip
) else (
..\stuff\tools\WIN\wget\wget -O"..\temp\dist.zip" %1
)

:unzip
..\stuff\tools\WIN\7z\7z x ..\temp\dist.zip -o..\temp\dist

for /f %%a in (..\temp\dist\meta) do (
  set name=%%a
  goto exit
)
:exit
ren ..\temp\dist !name!
del ..\temp\dist.zip