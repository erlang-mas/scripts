#!/usr/bin/env bash

results_dir=$SCRATCH/erlang-mas
scripts_dir=$HOME/erlang-mas/scripts/pbs/run

for _ in $(seq 1 10); do
  experiment_id=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

  experiment_path=$simulation_name/$num_nodes/$experiment_id
  experiment_dir=$results_dir/$experiment_path
  mkdir -p $experiment_dir

  logs_dir=$scripts_dir/logs/$experiment_path
  mkdir -p $logs_dir

  erlang_hosts=$experiment_dir/.hosts.erlang

  hosts=`cat $PBS_NODEFILE | uniq`

  printf $hosts | sort | awk '{printf "'\''%s'\''.\n", $0}' > $erlang_hosts

  for host in ${hosts[*]}; do
    pbsdsh -o -h $host $scripts_dir/run_node.sh $experiment_dir > $logs_dir/$host &
  done

  wait
done
