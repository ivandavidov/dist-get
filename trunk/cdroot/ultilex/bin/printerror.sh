#!/bin/sh

msg=$(sh readproperty.sh ../stuff/errors.properties $1 | sed "s/%1/$2/g")

echo 
echo "$msg"
echo 
