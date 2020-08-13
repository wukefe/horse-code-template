#!/bin/bash
usage(){
    printf '%s\n\n' \
        "Usage: (default optimization: release)" \
        "  1) $0 <kind> <qid>             ## kind: naive and opt" \
        "  2) $0 lib                      ## build libcore.a" \
        "  3) $0 code <naive/opt>         ## write code to opt" \
        "  4) $0 test <naive/opt> <qid>   ## test a query: generating C code from hir" \
        "  5) $0 gen  <qid>               ## compile lib + gen opt + save to opt/" \
        "  Note: default opt=opt2"
    exit 1
}

# query_set=(1 4 6 12 14 16 19 22)
query_set=`seq 22`
mykind="opt"
opt1="-o basic"
opt2="-o fp1 -o fa -o fp2"
if [ -z ${opt} ]; then
    opt=${opt2}
fi
HORSE_HYPER_HIR="/home/sable/hanfeng.c/github/branch-plan2ir/tests/hyper/work-hir"

compile_code(){
    kind=$1
    for id in ${query_set[@]}
    do
        echo "** [${kind}] Compiling query ${id} **"
        compile_single ${kind} ${id} > ${kind}/q${id}.h
    done
}

compile_code_naive(){
    kind="naive"
    mkdir -p ${kind}
    for id in ${query_set[@]}
    do
        echo "** [Naive] Compiling query ${id} **"
        compile_single ${kind} ${id} > ${kind}/q${id}.h
    done
}

compile_code_opt(){
    kind="opt"
    opt=""
    mkdir -p ${kind}
    for id in ${query_set[@]}
    do
        echo "** [Opt] Compiling query ${id} **"
        compile_single ${kind} ${id} > ${kind}/q${id}.h
    done
}

compile_single(){
    folder=$1 ; id=$2
    if [ ${folder} = "opt" ]; then
        ${HORSE_SRC_CODE}/build/horse -c cpu ${opt} -f ${HORSE_HYPER_HIR}/q${id}.hir --tpch=${id}
    elif [ ${folder} = "naive" ]; then
        ${HORSE_SRC_CODE}/build/horse -c cpu -f ${HORSE_HYPER_HIR}/q${id}.hir --tpch=${id}
    else
        usage
    fi
}


sys=`hostname`
if [ "$#" -eq 1 ]; then
    if [ $1 = "lib" ]; then
        (set -x && cd ${HORSE_SRC_CODE} && ./make.sh lib)
    else
        usage
    fi
elif [ "$#" -eq 2 ]; then
    folder=$1 ; id=$2
    if [ $1 = "opt" -o $1 = "naive" ]; then
        (set -x && cp "${folder}/q${id}.h" gencode.h && make q${id} debug=${debug})
    elif [ $1 = "code" ]; then
        if [ $2 = "opt" ]; then
            compile_code_opt
        elif [ $2 = "naive" ]; then
            compile_code_naive
        else
            usage
        fi
    elif [ $1 = "gen" ]; then
        (set -x && (cd ${HORSE_SRC_CODE} && ./make.sh debug) 1> /dev/null  && compile_single "opt" $2 > opt/q$2.h)
    else
        usage
    fi
elif [ "$#" -eq 3 ]; then
    if [ $1 = "test" ]; then
        (set -x && (cd ${HORSE_SRC_CODE} && ./make.sh debug) 1> /dev/null  && compile_single $2 $3)
    else
        usage
    fi
else
    usage
fi












