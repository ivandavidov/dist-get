@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION
cd ..\..

set menus=ultilex\cfg\menus.cfg
set additionals=ultilex\cfg\adds.cfg

if exist !menus! del !menus!
if exist !additionals! del !additionals!

for /D %%g in ("*") do (
	set dist=%%g
	if not !dist!==boot (
		if not !dist!==ultilex (
			if not !dist!==__metadata (
				if exist !dist!\meta\menu.cfg (
					echo INCLUDE /!dist!/meta/menu.cfg>>!menus!
				)
				if exist !dist!\meta\add.cfg (
					echo INCLUDE /!dist!/meta/add.cfg>>!additionals!
				)
			)
		)
	)
)