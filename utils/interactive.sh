#!/bin/bash -l

srun -p plgrid-testing -N 1 --ntasks-per-node=1 -n 1 -A plglogin --pty /bin/bash -l
