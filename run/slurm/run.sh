#!/usr/bin/env bash

nodes_min=10
nodes_max=100
nodes_step=10

simulation_name=`date +%s`
simulation_name+=_$nodes_min
simulation_name+=_$nodes_max

partition=plgrid
account=plglogin
time="00:10:00"
user=`id -u -n`

scripts_dir=$HOME/erlang-mas/scripts/run/slurm
slurm_logs_dir=$scripts_dir/logs/$simulation_name

mkdir -p $slurm_logs_dir

slurm_output_path=$slurm_logs_dir/slurm-%j.out
slurm_errors_path=$slurm_logs_dir/slurm-%j.error

for num_nodes in $(seq $nodes_min $nodes_step $nodes_max); do
  printf $num_nodes

  sbatch --partition=$partition \
         --account=$account \
         --nodes=$num_nodes \
         --ntasks=$num_nodes \
         --cpus-per-task=24 \
         --time=$time \
         --job-name=emas-$num_nodes \
         --mail-type=ALL \
         --mail-user=$user \
         --output=$slurm_output_path \
         --error=$slurm_errors_path \
         $scripts_dir/run_nodes.sh $simulation_name $num_nodes
done
