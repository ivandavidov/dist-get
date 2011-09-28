@echo off

for /f %%v in ('readproperty sample.properties key1') do set key1=%%v
for /f %%v in ('readproperty sample.properties key2') do set key2=%%v

echo key1 = %key1%
echo key2 = %key2%