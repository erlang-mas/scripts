#!/usr/bin/env bash

#PBS -N emas-compress
#PBS -l nodes=1:ppn=1,walltime=03:00:00
#PBS -A plglogin
#PBS -q l_short
#PBS -m abe
#PBS -M plglogin@example.com

results_path=$SCRATCH/erlang-mas

rm -rf $results_path/**/*/data.*
rm -rf $results_path/**/*/log.*

compressed_path=$results_path/$simulation_name
compressed_path+=".tar.gz"

tar -C $results_path -zcf $compressed_path $simulation_name
