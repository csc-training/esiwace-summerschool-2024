#!/bin/sh

#salloc --ntasks=4 --account=bb1153 --partition=shared --qos=esiwace --time=00:10:00 
salloc --ntasks=2 --cpus-per-task=4 --account=bb1153 --partition=shared --qos=esiwace --time=00:30:00
