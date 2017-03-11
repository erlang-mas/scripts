#!/usr/bin/env bash

. /etc/bashrc

experiment_dir=$1
cd $experiment_dir

module use $HOME/.modulefiles
module load erlang/19.2

emas_dir=$HOME/erlang-mas/emas

export NIF_DIR=$emas_dir/priv

epmd -daemon

$emas_dir/emas --population-count=24 \
                --population-size=100 \
                --migration-probability=0.001 \
                --node-migration-probability=0.0001 \
                --time=90000 \
                --output=$experiment_dir

killall epmd
