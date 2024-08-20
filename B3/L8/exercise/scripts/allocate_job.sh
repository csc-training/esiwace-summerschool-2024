#! bin/sh

salloc --nodes=1 --ntasks=4 --account=<project id> --partition=<partition> --time=00:10:00 
#salloc --nodes=1 --ntasks=4 --cpus-per-task=4 --account=<project id> --partition=<partition> --time=00:10:00
