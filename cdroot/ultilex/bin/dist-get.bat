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
echo ERROR: Required parameter is missing. Use 'dist-get help' to get more information.
echo.
goto end

:help
echo *** dist-get help page ***
echo.
echo Available options: 
echo. 
echo help                            Displays the current screen.
echo.
echo about                           Displays information about the authors of
echo                                 this project.
echo.
echo prepare URL_META_FILE [local]   Downloads and prepares a meta data bundle for
echo                                 certain distribution. The URL_META_FILE can
echo                                 be HTTP/HTTPS location or a local file.
echo                                 If it is a local file, you need to use the
echo                                 'local' parameter at the end of the command.
echo.
echo list                            Displays a list of all prepared and installed
echo                                 distributions.
echo.                                
echo install DISTRO_NAME [ISO_FILE]  Installs the DISTRO_NAME distribution. This
echo                                 requires active internet connection unless
echo                                 you provide a previously downloaded ISO file
echo                                 as additional parameter.
echo.
echo update DISTRO_NAME              Updates the DISTRO_NAME distribution. Please
echo                                 note that you have to retrieve the new meta
echo                                 data fisrt by executing 'dist-get prepare'.
echo.
echo remove DISTRO_NAME              Removes the DISTRO_NAME distribution.
echo.
echo reorganize                      Builds the boot menu. This command is executed
echo                                 automatically after install, update and remove.
echo.
echo cleanup [DISTRO_NAME]           Removes all temporary meta data. You can remove
echo                                 meta data for DISTRO_NAME by providing it as
echo                                 additional parameter. This command is executed
echo                                 automatically before usbinstall or makeiso.
echo.
echo usbinstall                      Makes the current USB device to be bootable.
echo.
echo makeiso                         Creates a single CD ISO image which contains
echo                                 all installed distributions.
echo.
goto end

:prepare
call prepare %2 %3
goto end

:list
call list
goto end

:about
echo.
echo *** ULTILEX powered by 'dist-get' ***
echo.
echo List of all contributors (in alphabet order):
echo.
echo Ivan Davidov, Sofia, Bulgaria (ivan.bgzin.com)
echo.
echo Peter Chakalov, Sliven, Bulgaria (peter.chakalov@gmail.com)
echo.
goto end

:install
call install %2 %3
call reorganize
goto end

:update
checkupdate %2

if exist temp_eq.tmp (
    del temp_eq.tmp

    echo.
    echo The distribution '%2' is already up to date.
    echo.    
)

if exist temp_neq.tmp (
    del temp_eq.tmp
    
    call delete %2
	call install %2
	call reorganize
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
echo ERROR: Parameter '%1' is not recognized by 'dist-get'.
echo.

:end
