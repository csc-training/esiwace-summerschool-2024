#!/bin/sh

#SBATCH --job-name=hello
#SBATCH --partition=<partition>
#SBATCH --account=<project>
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
##SBATCH --cpus-per-task

srun ./application

