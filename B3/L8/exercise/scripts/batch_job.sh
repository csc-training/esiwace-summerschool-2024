#!/bin/sh

#SBATCH --job-name=hello
#SBATCH --partition=shared
#SBATCH --account=bb1153
#SBATCH --qos=esiwace
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
##SBATCH --cpus-per-task=4

srun ./application

