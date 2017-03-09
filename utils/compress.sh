#!/bin/bash -l

#SBATCH -J emas-compress
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --time=05:00:00
#SBATCH -A plglogin
#SBATCH -p plgrid

results_path=$SCRATCH/erlang-mas/$1

rm -rf $results_path/**/*/data.*
rm -rf $results_path/**/*/log.*

compressed_path=$results_path
compressed_path+=".tar.gz"

srun tar -zcf $compressed_path $results_path
