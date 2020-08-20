#!/bin/bash
machine=`hostname`
runs=10
query_set=`seq 22`
# query_set=(1 4 6 12 14 16 19 22)
# query_set=(6)
# sf_set=(1 2 4 8 16)
sf_set=(1)

usage(){
    printf '%s\n\n' \
        "$0 <option>" \
        "  1) $0 <run_id>                   # specify a run id (opt only)" \
        "  2) $0 <run_id> time [report]     # get or report compilation time" \
        "  3) $0 <run_id> report <thread>   # report execution time under a thread" \
        "  4) $0 <run_id> single <qid>      # run a single query" \
        "  5) $0 ls                         # show run IDs" \
        "Note:" \
        "  * default: mysf=1, mykind=\"opt\""
    exit 1 
}

if [ -z ${mysf} ]; then
    mysf=1
fi

if [ -z ${mykind} ]; then
    mykind="opt"
fi

error(){
    echo "[ERROR] $1"
    exit 99
}

set_env(){
    if [ $machine = "sableintel" ]; then
        if [ -z ${single_thread} ]; then
            threads=(1 2 4 8 16 32 64)
        else
            threads=(${single_thread})
        fi
    elif [ $machine = "tigger" ]; then
        threads=(1 2 4 8 16)
    else
        error "This repository is only for the machine <sableintel> and <tigger>, NOT for *${machine}*"
    fi
}

run_build(){
    local kind=$1
    local log_file="${log_folder}/build_log_${kind}.txt"
    rm -f ${log_file}
    echo "** Logging to ${log_file} **"
    for id in ${query_set[@]}
    do
        echo "** Building query $id **"
        debug="-DNO_PROFILE_INFO" ./make.sh ${kind} ${id} &>> ${log_file}
    done
}

run_build_time(){
    local log_file="${log_folder}/build_log_${mykind}_time.txt"
    rm -f ${log_file}
    echo "** Logging to ${log_file} **"
    for id in ${query_set[@]}
    do
        echo "** Compiling query $id **"
        (set -x &&
            cp "${mykind}/q${id}.h" gencode.h && 
            time make q${id} sys=${machine} debug="-DNO_PROFILE_INFO" report="-ftime-report") &>> ${log_file}
    done
}

run_main(){
    local kind=$1
    local sf=$2
    local thread=$3
    local log_file="${log_folder}/${kind}_sf${sf}_t${thread}.txt"
    echo "** Logging to ${log_file} **"
    rm -f ${log_file}
    for id in ${query_set[@]}
    do
        ./run-query.sh ${id} ${runs} ${thread} ${sf} &>> ${log_file}
    done
}

run_one(){
    run_build $1
    for sf in ${sf_set[@]}
    do
        for thread in ${threads[@]}
        do
            run_main $1 ${sf} ${thread}
        done
    done
    # run_report $1
}

run_all(){
    run_one "opt"
}

run_single(){
    id=$1
    (set -x && debug="-DNO_PROFILE_INFO" ./make.sh ${mykind} ${id})
    for thread in ${threads[@]}
    do
        local log_file="${log_folder}/single_q${id}_t${thread}.txt"
        echo "** Logging to ${log_file} **"
        ./run-query.sh ${id} ${runs} $thread &> ${log_file}
    done
    # fetch ...
    for thread in ${threads[@]}
    do
        local log_file="${log_folder}/single_q${id}_t${thread}.txt"
        cat ${log_file} | grep "Run with" | cut -d'|' -f 1 | awk -F " " '{print $NF}'
    done
}


run_report(){
    local thread=$1
    local log_file="${log_folder}/${mykind}_sf${mysf}_t${thread}.txt"
    echo "Fetch execution time from ${log_file}"
    cat ${log_file} | grep "Run with" | cut -d'|' -f 1 | awk -F " " '{print $NF}'
}

run_report_build(){
    local log_file="${log_folder}/build_log_${kind}_time.txt"
    echo "Fetch compilation time (ms) from ${log_file}"
    cat ${log_file} | grep "TOTAL" | awk -F " " '{print $5}' | python util/report-all.py
}

set_log(){
    log_folder="log/run$1"
    mkdir -p ${log_folder}
}

set_env
if [ $# -eq 1 ]; then
    if [ $1 = "ls" ]; then
        ls log
    else
        set_log $1
        time run_all
    fi
elif [ $# -eq 2 ]; then
    if [ $2 = "time" ]; then
        set_log $1
        time run_build_time
    elif [ $2 = "report" ]; then
        set_log $1
        run_report_all
    else
        usage
    fi
elif [ $# -eq 3 ]; then
    if [ $2 = "report" ]; then
        set_log $1
        run_report $3
    elif [ $2 = "time" -a $3 = "report" ]; then
        set_log $1
        echo "** [Opt] Compilation time (ms) **"
        run_report_build "opt"
    elif [ $2 = "single" ]; then
        set_log $1
        run_single $3
    else
        usage
    fi
else
    usage
fi
