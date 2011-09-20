@echo off

:meta
echo.
echo Available meta data:
echo.

set /a counter=0

if not exist ..\temp (
    echo --nothing--
    goto distro
)

cd ..\temp

for /d %%v in (*) do (
    echo %%v
	set /a counter+=1    
)

if "!counter!" == "0" (
    echo --nothing--
)

cd ..\bin

goto distro

:distro
cd ..\..\

echo.
echo Installed distributions:
echo.

set /a counter=0

for /d %%v in (*) do (
    if not "%%v" == "boot" (
        if not "%%v" == "ultilex" (
            echo %%v
        )
    )

	set /a counter+=1
)

if "!counter!" == "2" (
    echo --nothing--
)

echo.

cd .\ultilex\bin

goto end

:end
