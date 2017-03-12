#!/usr/bin/env bash

#SBATCH -J emas-compress
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --time=05:00:00
#SBATCH -A plglogin
#SBATCH -p plgrid

results_path=$SCRATCH/erlang-mas

rm -rf $results_path/**/*/data.*
rm -rf $results_path/**/*/log.*

compressed_path=$results_path/$1
compressed_path+=".tar.gz"

srun tar -C $results_path -zcf $compressed_path $1
