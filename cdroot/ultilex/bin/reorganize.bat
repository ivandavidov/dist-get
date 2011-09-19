@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION

cd ..\..

set menus=ultilex\cfg\menus.cfg
set additionals=ultilex\cfg\adds.cfg

echo. 2>!menus!
echo. 2>!additionals!

for /D %%g in ("*") do (
	set dist=%%g
	if not !dist!==boot (
		if not !dist!==ultilex (
            if exist !dist!\meta\menu.cfg (
                echo INCLUDE /!dist!/meta/menu.cfg>>!menus!
            )
            if exist !dist!\meta\add.cfg (
                echo INCLUDE /!dist!/meta/add.cfg>>!additionals!
            )
		)
	)
)

cd ultilex\bin
