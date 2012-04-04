@echo off

if (%1) == () goto all
goto custom

:all
REM *********************************
REM Remove all temp directories BEGIN
REM *********************************
cd ..\..\
for /d %%v in (*) do (
    if not "%%v"=="boot" (
        if not "%%v"=="ultilex" (
            if exist %%v\temp rmdir /s /q %%v\temp
			set is_empty=1
			for /f %%f in ('dir /b "%%v\meta\*.*"') do (
				set is_empty=0
			)
			if !is_empty!==1 (
				rmdir /s /q %%v
			)
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
