#!/bin/bash
#SBATCH --account=bb1153
#SBATCH --ntasks=1
#SBATCH --time=00:15:00
#SBATCH --gpus=2
#SBATCH --partition=gpu
#SBATCH --reservation=esiwace_warmworld

srun ./hello

# Submit to the batch job queue with the command:
#  sbatch job.sh

# or alternatively, run directly from the command line:
#  srun --account=bb1153 --ntasks=1 --time=00:15:00 --gpus=2 \
#       --partition=gpu --reservation=esiwace_warmworld ./hello
