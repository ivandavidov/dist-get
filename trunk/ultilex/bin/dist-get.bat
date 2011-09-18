@echo off

if %1 == prepare goto prepare
if %1 == install goto install
if %1 == update goto update
if %1 == remove goto remove
if %1 == reorganize goto reorganize
if %1 == usbinstall goto usbInstall
if %1 == makeiso goto makeIso
goto commandNotFound

:prepare
prepare %2
goto end

:install
install %2
goto end

:update
goto end

:remove
goto end

:reorganize
reorganize
goto end

:usbInstall
goto end

:makeIso
goto end

:commandNotFound
echo Command not found!

:end