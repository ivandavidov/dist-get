@echo off

if (%1) == () goto missingParameter

if exist ..\..\%1 rmdir /s /q ..\..\%1

goto end

:missingParameter
echo.
call printerror missing_param
echo.

goto end

:end
