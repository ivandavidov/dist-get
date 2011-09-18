@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

set /a counter=0
set /a error=0
set meta=..\temp\%1

for /f %%a in (!meta!\meta) do (
	if "!counter!"=="0" (
		set name=%%a
	)
	if "!counter!"=="1" (
		set dir=..\..\%%a
		if exist !dir! (
			set error=1
			goto error
		)
		mkdir !dir!
		mkdir !dir!\meta
		xcopy !meta! !dir!\meta\ /s /e
	)
	if "!counter!"=="2" (
		set newMD5=%%a
	)
	if "!counter!"=="3" (
		set url=%%a
		..\stuff\tools\WIN\wget\wget -O"..\temp\!name!.iso" !url!
		echo "Download complete"
		..\stuff\tools\WIN\7z\7z x ..\temp\!name!.iso -o..\temp\!name!
	)
	set /a counter+=1
)

set dest="NOTSET"
for /f %%a in (!meta!\includes.win) do (
	if !dest!=="NOTSET" (
		set source=%%a
		set dest="SET"
	) else (
		echo ..\temp\!name!\!source! !dir!%%a /s /e
		xcopy ..\temp\!name!\!source! !dir!%%a /s /e
		set dest="NOTSET"
	)
)

:error
if "!error!"=="1" echo Error