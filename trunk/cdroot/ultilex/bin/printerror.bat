@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

for /f "tokens=* delims= " %%v in ('readproperty ..\stuff\errors.properties %1') do set msg=%%v
echo !msg! > tmpfile.tmp

set /a cnt=0
for %%x in (%*) do (
	if not !cnt!==0 (
		..\stuff\tools\WIN\properties\sed "s/%%!cnt!/%%x/g" tmpfile.tmp > tmpfile2.tmp
		for /f "tokens=* delims= " %%v in (tmpfile2.tmp) do (
			echo %%v > tmpfile.tmp
		)
		del tmpfile2.tmp
	)
	set /a cnt+=1
)

for /f "tokens=* delims= " %%v in (tmpfile.tmp) do (
	echo %%v
	goto exitloop
)
:exitloop

del tmpfile.tmp