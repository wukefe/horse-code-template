#!/bin/bash

usage(){
    printf '%s\n\n' \
        "Usage: (default runs=1, threads=1, scale=1)" \
        "  1) $0 <id>" \
        "  1) $0 <id> <runs>" \
        "  2) $0 <id> <runs> <threads>" \
        "  3) $0 <id> <runs> <threads> <scale>"
    exit 1
}

runs=1 # number of runs
threads=1 # number of threads
scale=1

run_main(){
    export OMP_PLACES=cores
    export OMP_PROC_BIND=spread
    #export OMP_PROC_BIND=true # For PGI
    export OMP_NUM_THREADS=$threads

    echo "`hostname`> q${qid}, T$threads, Run$runs, SF$scale"
    (set -x && ./compile-q${qid} $scale $runs)
}

if [ "$#" -eq 1 ]; then
    qid=$1
    runs=1
    threads=1
    scale=1
elif [ "$#" -eq 2 ]; then
    qid=$1
    runs=$2
    threads=1
    scale=1
elif [ "$#" -eq 3 ]; then
    qid=$1
    runs=$2
    threads=$3
    scale=1
elif [ "$#" -eq 4 ]; then
    qid=$1
    runs=$2
    threads=$3
    scale=$4
else
    usage
fi

run_main

