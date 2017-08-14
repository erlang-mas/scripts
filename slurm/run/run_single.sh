#!/usr/bin/env bash

nodes_count=$1
repetitions=$2
series=emas_$nodes_count

mps=(0.5 0.25 0.05)

for i in $(seq 1 $repetitions); do
    echo "Repetition #$i"
    echo -e "Nodes\tMP\tNMP\tT\tNT"

    for mp in "${mps[@]}"; do
        debug_info="$nodes_count\t$mp\t0.0"

        echo -e "$debug_info\tmesh\tmesh"
        ./run.sh $nodes_count $mp 0.0 mesh mesh ${series}_mesh_mesh

        echo -e "$debug_info\tgrid\tgrid"
        ./run.sh $nodes_count $mp 0.0 grid grid ${series}_grid_grid

        echo -e "$debug_info\tmesh\tgrid"
        ./run.sh $nodes_count $mp 0.0 mesh grid ${series}_mesh_grid
    done
done
