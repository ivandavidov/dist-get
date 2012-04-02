@echo off
echo %1 | ..\stuff\tools\WIN\properties\sed "s/.*\///g" | ..\stuff\tools\WIN\properties\sed "s/.*\\//g" | ..\stuff\tools\WIN\properties\sed "s/\..*//"