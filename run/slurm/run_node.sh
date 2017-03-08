#!/usr/bin/env bash

. /etc/bashrc

experiment_dir=$1
cd $experiment_dir

emas_root=$HOME/erlang-mas/emas

module use $HOME/.modulefiles
module load erlang/19.2

epmd -daemon

export NIF_DIR=$emas_root/priv

$emas_root/emas --population-count=24 \
                --population-size=100 \
                --migration-probability=0.001 \
                --node-migration-probability=0.001 \
                --time=90000 \
                --output=$experiment_dir >> $HOME/test.logs

killall epmd
