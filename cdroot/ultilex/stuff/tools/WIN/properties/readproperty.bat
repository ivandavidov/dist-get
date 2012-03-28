@echo off

sed "/^\#/d" %1 | grep %2 | sed "s/^.*=//" > tmpfile.tmp

for /f %%v in (tmpfile.tmp) do (
    echo %%v
    
    goto exitloop
)

:exitloop

del tmpfile.tmp