@echo off

:meta
echo.
echo Available meta data:
echo.

cd ..\..\

set /a counter=0

for /d %%v in (*) do (
    if not "%%v"=="boot" (
        if not "%%v"=="ultilex" (
            if exist %%v\temp\meta (
				echo %%v
				set /a counter+=1
			)
        )
    )
)

if "!counter!"=="0" (
    echo --nothing--
)

echo.

cd .\ultilex\bin

goto distro

:distro
cd ..\..\

echo.
echo Installed distributions:
echo.

set /a counter=0

for /d %%v in (*) do (
    if not "%%v"=="boot" (
        if not "%%v"=="ultilex" (
			if exist %%v\meta\meta (
				echo %%v
				set /a counter+=1
			)
        )
    )
)

if "!counter!"=="0" (
    echo --nothing--
)

echo.

cd .\ultilex\bin

goto end

:end
