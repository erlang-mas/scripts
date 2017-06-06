#!/usr/bin/env bash

. /etc/bashrc

experiment_dir=$1

migration_probability=$2
node_migration_probability=$3
topology=$4
nodes_topology=$5

cd $experiment_dir

module use $HOME/.modulefiles
module load erlang/19.2

emas_dir=$HOME/erlang-mas/emas

export NIF_DIR=$emas_dir/priv

epmd -daemon

$emas_dir/emas --population-count=24 \
               --population-size=100 \
               --problem-size=1000 \
               --migration-probability=$migration_probability \
               --node-migration-probability=$node_migration_probability \
               --time=300000 \
               --genetic-ops=emas_rastrigin_ops \
               --topology=$topology \
               --nodes-topology=$nodes_topology \
               --output=$experiment_dir

killall epmd
