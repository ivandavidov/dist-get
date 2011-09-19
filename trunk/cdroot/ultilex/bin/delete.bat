@echo off

if (%1) == () goto missingParameter

if exist ..\..\%1 rmdir /s /q ..\..\%1

goto end

:missingParameter
echo.
echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
echo.

goto end

:end
