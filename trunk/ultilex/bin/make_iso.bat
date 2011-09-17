@ECHO OFF

cd ..
cd ..
set CDLABEL=ULTILEX

ultilex\stuff\tools\WIN\mkisofs\mkisofs.exe @ultilex\stuff\tools\WIN\mkisofs\config -o "../ultilex.iso" -A "%CDLABEL%" -V "%CDLABEL%" .
echo.
echo New ISO should be created now.
goto theend

:error1
echo A parameter is required - target ISO file.
echo Example: %0 c:\target.iso
goto theend

:error2
echo Error creating the ISO file
goto theend

:theend
pause
