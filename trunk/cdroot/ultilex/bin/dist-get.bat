@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

if (%1) == () goto missing
if (%1) == (help) goto help
if (%1) == (about) goto about
if (%1) == (prepare) goto prepare
if (%1) == (list) goto list
if (%1) == (install) goto install
if (%1) == (update) goto update
if (%1) == (remove) goto remove
if (%1) == (reorganize) goto reorganize
if (%1) == (cleanup) goto cleanUp
if (%1) == (usbinstall) goto usbInstall
if (%1) == (makeiso) goto makeIso
goto commandNotFound

:missing
echo.
call printerror missing_param
echo.
goto end

:help
type ..\stuff\help.txt | more
goto end

:prepare
call prepare %2 %3
goto end

:list
call list
goto end

:about
type ..\stuff\about.txt | more
goto end

:install
call install %2 %3
call reorganize
goto end

:update
call checkupdate %2

if exist temp_eq.tmp (
    del temp_eq.tmp

    echo.
    call printerror dist_up_to_date %2
    echo.    
) else (
	if exist temp_neq.tmp (
		del temp_neq.tmp
		
		if not exist ..\temp mkdir ..\temp
		xcopy ..\..\%2\temp\meta ..\temp
		xcopy ..\..\%2\temp\includes ..\temp
		xcopy ..\..\%2\temp\add.cfg ..\temp
		xcopy ..\..\%2\temp\menu.cfg ..\temp
		call delete %2
		mkdir ..\..\%2
		mkdir ..\..\%2\meta
		mkdir ..\..\%2\temp
		xcopy ..\temp ..\..\%2\temp /s /e /y
		rmdir /s /q ..\temp
		call install %2
		call reorganize
	)
)

goto end

:remove
call delete %2
call reorganize
goto end

:reorganize
call reorganize
goto end

:cleanUp
call cleanup %2
goto end

:usbInstall
call cleanup
call bootinst
goto end

:makeIso
call cleanup
call make_iso
goto end

:commandNotFound
echo.
call printerror command_not_found %1
echo.

:end
