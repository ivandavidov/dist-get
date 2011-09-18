@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if %1 == prepare goto prepare
if %1 == install goto install
if %1 == update goto update
if %1 == remove goto remove
if %1 == reorganize goto reorganize
if %1 == cleanup goto cleanUp
if %1 == usbinstall goto usbInstall
if %1 == makeiso goto makeIso
goto commandNotFound

:prepare
prepare %2 %3
goto end

:install
install %2
reorganize
goto end

:update
for /f "tokens=*" %%i in ('checkupdate %2') do set hasUpdate=%%i
if "!hasUpdate!"=="1" (
	delete %2
	install %2
	reorganize
) else echo "No need to update"
goto end

:remove
delete %2
reorganize
goto end

:reorganize
reorganize
goto end

:cleanUp
cleanup
goto end

:usbInstall
goto end

:makeIso
goto end

:commandNotFound
echo Command not found!

:end