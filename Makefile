# Note:
# libhorse.a must be placed before libpcre2-8.a

cccc = gcc-8
include_files = main.c 
include_dirs  = -I${HORSE_LIB_INCLUDE} -I${HORSE_SRC_CODE}
include_libs  = -L${HORSE_LIB_LIB} -lcore -lpcre2-8
include_flags = -O3 -std=c99 -fopenmp -lm -lstdc++ -march=native
include_flags_c = $(include_flags) -DSELECT_C # -v -ftime-report

all: message

q%:
	$(cccc) -o "compile-$@" \
    $(include_files)   \
    $(include_dirs)    \
    $(include_libs)    \
    $(include_flags_c) \
    $(debug) $(report)

message:
	@echo "Please use ./make.sh"

