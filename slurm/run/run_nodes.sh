#!/usr/bin/env bash

simulation_name=$1
num_nodes=$2

migration_probability=$3
node_migration_probability=$4
topology=$5
nodes_topology=$6

results_dir=$SCRATCH/erlang-mas
scripts_dir=$HOME/erlang-mas/scripts/slurm/run

for _ in $(seq 1 1); do
  experiment_id=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

  experiment_name=nodes_$num_nodes
  experiment_name+=_mp_$migration_probability
  experiment_name+=_nmp_$node_migration_probability
  experiment_name+=_$topology
  experiment_name+=_$nodes_topology

  experiment_path=$simulation_name/$experiment_name/$experiment_id
  experiment_dir=$results_dir/$experiment_path
  mkdir -p $experiment_dir

  slurm_logs_dir=$scripts_dir/logs/$experiment_path
  mkdir -p $slurm_logs_dir

  slurm_output_path=$slurm_logs_dir/%N.out
  slurm_errors_path=$slurm_logs_dir/%N.error

  erlang_hosts=$experiment_dir/.hosts.erlang

  srun --ntasks=$num_nodes \
       --label \
       /bin/hostname | sort -n | awk '{printf "'\''%s'\''.\n", $2}' > $erlang_hosts
  wait
  srun --ntasks=$num_nodes \
       --output=$slurm_output_path \
       --error=$slurm_errors_path \
       $scripts_dir/run_node.sh $experiment_dir $migration_probability $node_migration_probability $topology $nodes_topology
  wait
done
