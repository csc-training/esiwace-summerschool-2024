#! bin/sh

salloc --ntasks=4 --account=<project id> --partition=<partition> --qos=esiwace --time=00:10:00 
#salloc --ntasks=1 --cpus-per-task=4 --account=<project id> --partition=<partition> --qos=esiwace --time=00:10:00
