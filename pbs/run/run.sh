#!/usr/bin/env bash

nodes_min=10
nodes_max=100
nodes_step=10

simulation_name=`date +%s`
simulation_name+=_$nodes_min
simulation_name+=_$nodes_max

queue=l_short
account=plglogin
email=plglogin@example.com
time="00:10:00"

scripts_dir=$HOME/erlang-mas/scripts/pbs/run

for num_nodes in $(seq $nodes_min $nodes_step $nodes_max); do
  printf $num_nodes

  qsub -q $queue \
       -A $account \
       -l nodes=$num_nodes:ppn=12,walltime=$time \
       -N emas-$num_nodes \
       -m abe \
       -M $email \
       -v simulation_name=$simulation_name,num_nodes=$num_nodes \
       $scripts_dir/run_nodes.sh
done
