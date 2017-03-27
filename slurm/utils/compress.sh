#!/usr/bin/env bash

#SBATCH --job-name emas-compress
#SBATCH --ntasks 1
#SBATCH --time=05:00:00
#SBATCH --account plglogin
#SBATCH --partition plgrid
#SBATCH --mail-type ALL
#SBATCH --mail-user plglogin

results_path=$SCRATCH/erlang-mas

rm -rf $results_path/**/*/data.*
rm -rf $results_path/**/*/log.*

compressed_path=$results_path/$1
compressed_path+=".tar.gz"

srun tar -C $results_path -zcf $compressed_path $1
