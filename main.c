#include "global.h"
#include <math.h>

#define MAX_V 1000
static V buffV[MAX_V];
static I buffS = 0;
extern L CSV_FILE_SCALE;

#include "header.h"
#include "gencode.h" 

static void initTPCHQuery(I id){
    initBackend();
    initTablesByQid(id);
    DOI(MAX_V, buffV[i]=allocNode())
}

static void clearRun(L cur){
    setHeapOffset(cur);
    time_clear();
}

static void run(I id, I n){
    initTPCHQuery(id);
    I offset = 5;
    I n2 = n + offset;
    E *record=(E*)malloc(sizeof(E)*n2), total=0;
    L cur = getHeapOffset();
    DOI(n2, {clearRun(cur); record[i]=horse_entry();})
    DOI(n, total += record[i+offset])
    P("q%02d>> Run with %d times, last %d average (ms): %g |",id,n2,n,total/n);
    DOI(n2, P(" %g",record[i])) P("\n");
    free(record);
}

static I getId(S str){
    I len=strlen(str), x=len-1;
    while(x>=0 && str[x]!='q') x--;
    if(x>=0)
        return atoi(str+x+1);
    else {
        EP("Not a valid executable: %s, but horse-compile-q<id> is expected", str);
    }
}

int main(int argc, char** argv){
    if(argc!=3){
        printf("[Usage]: %s <scale> <run>\n",argv[0]);
        exit(1);
    }
    I id    = getId(argv[0]);
    L scale = atoi(argv[1]);
    I n     = atoi(argv[2]);
    if(n<0){ EP("[run]: must be >=0"); }
    if(scale != 1 && scale != 2 && scale!=4 && scale!=8 && scale!=16) {
        EP("scale must be one of 1/2/4/8/16");
    }
    CSV_FILE_SCALE = scale;
    run(id, n);
    return 0;
}

