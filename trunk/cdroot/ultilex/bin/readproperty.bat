@echo off

..\stuff\tools\WIN\properties\sed "/^\#/d" %1 | ..\stuff\tools\WIN\properties\grep %2 | ..\stuff\tools\WIN\properties\sed "s/^.*=//" > tmpfile.tmp

for /f %%v in (tmpfile.tmp) do (
    echo %%v
    
    goto exitloop
)

:exitloop

del tmpfile.tmp