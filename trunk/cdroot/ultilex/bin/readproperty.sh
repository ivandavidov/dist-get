#!/bin/sh

sed "/^\#/d" $1 | grep $2 | sed "s/^.*=//"
