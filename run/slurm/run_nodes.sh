#!/usr/bin/env bash

simulation_dir=$1

retries=10

for _ in $(seq 1 $retries); do
  experiment_id=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`
  experiment_dir=$simulation_dir/$experiment_id

  mkdir -p $experiment_dir

  srun -l /bin/hostname | sort -n | awk '{printf "'\''%s'\''.\n", $2}' > $experiment_dir/.hosts.erlang
  srun $HOME/erlang-mas/scripts/run/slurm/run_node.sh $experiment_dir
done
