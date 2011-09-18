@echo off
SETLOCAL=ENABLEDELAYEDEXPANSION
cd ..\..

set menus=ultilex\cfg\menus.cfg
set additionals=ultilex\cfg\additionals.cfg

if exist !menus! del !menus!
if exist !additionals! del !additionals!

for /D %%g in ("*") do (
	set dist=%%g
	if not !dist!==boot (
		if not !dist!==ultilex (
			if exist !dist!\meta\menu.cfg (
				echo INCLUDE !dist!\meta\menu.cfg>>!menus!
			)
			if exist !dist!\meta\additional.cfg (
				echo INCLUDE !dist!\meta\additional.cfg>>!additionals!
			)
		)
	)
)