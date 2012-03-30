@echo off

if (%1) == () goto all
goto custom

:all
REM *********************************
REM Remove all temp directories BEGIN
REM *********************************
if exist ..\temp rmdir /s /q ..\temp

cd ..\..\
for /d %%v in (*) do (
    if not "%%v"=="boot" (
        if not "%%v"=="ultilex" (
            if exist %%v\temp rmdir /s /q %%v\temp
        )
    )
)
cd .\ultilex\bin
REM *******************************
REM Remove all temp directories END
REM *******************************

goto end

:custom
if exist ..\..\%1\temp rmdir /s /q ..\..\%1\temp
goto end

:end
