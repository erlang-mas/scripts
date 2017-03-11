#!/bin/bash -l

#SBATCH -J emas-cleanup
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --time=01:00:00
#SBATCH -A plglogin
#SBATCH -p plgrid

rm -rf $SCRATCH/erlang-mas/$1
