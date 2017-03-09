#!/bin/bash -l

#SBATCH -J emas-compress
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --time=05:00:00
#SBATCH -A plglogin
#SBATCH -p plgrid

results_path=$1

cd $SCRATCH/erlang-mas

compressed_path=$results_path
compressed_path+=".tar.gz"

srun tar -zcvf $compressed_path $results_path
