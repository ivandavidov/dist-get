@echo off

if (%1) == () goto all
goto custom

:all
if exist ..\temp rmdir /s /q ..\temp
goto end

:custom
if exist ..\temp\%1 rmdir /s /q ..\temp\%1
goto end

:end
