#!/usr/bin/env bash

nodes_count=$1
migration_probability=$2
node_migration_probability=$3
topology=$4
nodes_topology=$5
simulation_name=$5

# simulation_name=`date +%s`
# simulation_name+=_$nodes_min
# simulation_name+=_$nodes_max

partition=plgrid
account=plglogin
time="00:08:00"
user=`id -u -n`

scripts_dir=$HOME/erlang-mas/scripts/slurm/run

sbatch --partition=$partition \
       --account=$account \
       --nodes=$nodes_count \
       --ntasks=$nodes_count \
       --cpus-per-task=24 \
       --time=$time \
       --job-name=emas-$nodes_count \
       --mail-type=ALL \
       --mail-user=$user \
       $scripts_dir/run_nodes.sh $simulation_name $nodes_count $migration_probability $node_migration_probability $topology $nodes_topology
