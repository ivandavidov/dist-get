@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

mkdir ..\temp
..\stuff\tools\WIN\wget\wget -O"..\temp\dist" %1

for /f %%a in (..\temp\dist) do (
  set name=%%a
  goto exit
)
:exit
ren ..\temp\dist !name!