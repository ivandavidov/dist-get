@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

set /a counter=0
set oldMeta=..\..\%1\meta
set newMeta=..\temp\%1

for /f %%a in (!oldMeta!\meta) do (
	if "!counter!"=="2" (
		set oldMD5=%%a
	)
	set /a counter+=1
)

set /a counter=0

for /f %%a in (!newMeta!\meta) do (
	if "!counter!"=="2" (
		set newMD5=%%a
	)
	set /a counter+=1
)

if !newMD5!==!oldMD5! (
	echo 0
) else (
	echo 1
)