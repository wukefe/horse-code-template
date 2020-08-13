// Parsing time (ms): 0.652
static I horse_main(V *h_rtn);


static I horse_main(V *h_rtn){
    V t0 = incV(); V t6 = incV(); V t7 = incV(); V t8 = incV(); 
    V t9 = incV(); V t10 = incV(); V t11 = incV(); V t12 = incV(); 
    V t23 = incV(); V t40 = incV(); V t24 = incV(); V t41 = incV(); 
    V t25 = incV(); V t50 = incV(); V t42 = incV(); V t26 = incV(); 
    V t18 = incV(); V t51 = incV(); V t43 = incV(); V t35 = incV(); 
    V t27 = incV(); V t60 = incV(); V t52 = incV(); V t44 = incV(); 
    V t36 = incV(); V t28 = incV(); V t61 = incV(); V t53 = incV(); 
    V t45 = incV(); V t37 = incV(); V t70 = incV(); V t62 = incV(); 
    V t54 = incV(); V t46 = incV(); V t38 = incV(); V t71 = incV(); 
    V t63 = incV(); V t55 = incV(); V t47 = incV(); V t39 = incV(); 
    V t80 = incV(); V t72 = incV(); V t64 = incV(); V t56 = incV(); 
    V t48 = incV(); V t81 = incV(); V t73 = incV(); V t57 = incV(); 
    V t49 = incV(); V t82 = incV(); V t74 = incV(); V t58 = incV(); 
    V t83 = incV(); V t75 = incV(); V t59 = incV(); V t84 = incV(); 
    V t76 = incV(); V t68 = incV(); V t85 = incV(); V t77 = incV(); 
    V t69 = incV(); V t86 = incV(); V t78 = incV(); V t87 = incV(); 
    V t79 = incV(); V t88 = incV(); 
    V tempV[10]; // temporary return vars
    PROFILE(4, pfnLoadTable(t0, LiteralSymbol("lineitem")));
    PROFILE(5, pfnColumnValue(t6, t0, LiteralSymbol("l_quantity")));
    PROFILE(6, pfnColumnValue(t7, t0, LiteralSymbol("l_extendedprice")));
    PROFILE(7, pfnColumnValue(t8, t0, LiteralSymbol("l_discount")));
    PROFILE(8, pfnColumnValue(t9, t0, LiteralSymbol("l_tax")));
    PROFILE(9, pfnColumnValue(t10, t0, LiteralSymbol("l_returnflag")));
    PROFILE(10, pfnColumnValue(t11, t0, LiteralSymbol("l_linestatus")));
    PROFILE(11, pfnColumnValue(t12, t0, LiteralSymbol("l_shipdate")));
    PROFILE(12, pfnLeq(t18, t12, LiteralDate(19980902)));
    PROFILE(13, pfnCompress(t23, t18, t6));
    PROFILE(14, pfnCompress(t24, t18, t7));
    PROFILE(15, pfnCompress(t25, t18, t8));
    PROFILE(16, pfnCompress(t26, t18, t9));
    PROFILE(17, pfnCompress(t27, t18, t10));
    PROFILE(18, pfnCompress(t28, t18, t11));
    PROFILE(19, pfnMinus(t35, LiteralI32(1), t25));
    PROFILE(20, pfnMul(t36, t24, t35));
    PROFILE(21, pfnPlus(t37, LiteralI32(1), t26));
    PROFILE(22, pfnMinus(t38, LiteralI32(1), t25));
    PROFILE(23, pfnMul(t39, t24, t38));
    PROFILE(24, pfnMul(t40, t39, t37));
    PROFILE(25, pfnList(t41, 2, (V []){t27, t28}));
    PROFILE(26, pfnGroup(t42, t41));
    PROFILE(27, pfnKeys(t43, t42));
    PROFILE(28, pfnValues(t44, t42));
    PROFILE(29, pfnIndex(t45, t27, t43));
    PROFILE(30, pfnIndex(t46, t28, t43));
    PROFILE(31, pfnEachRight(t47, t23, t44, pfnIndex));
    PROFILE(32, pfnEach(t48, t47, pfnSum));
    PROFILE(33, pfnRaze(t49, t48));
    PROFILE(34, pfnEachRight(t50, t23, t44, pfnIndex));
    PROFILE(35, pfnEach(t51, t50, pfnAvg));
    PROFILE(36, pfnRaze(t52, t51));
    PROFILE(37, pfnEachRight(t53, t24, t44, pfnIndex));
    PROFILE(38, pfnEach(t54, t53, pfnSum));
    PROFILE(39, pfnRaze(t55, t54));
    PROFILE(40, pfnEachRight(t56, t24, t44, pfnIndex));
    PROFILE(41, pfnEach(t57, t56, pfnAvg));
    PROFILE(42, pfnRaze(t58, t57));
    PROFILE(43, pfnEachRight(t59, t36, t44, pfnIndex));
    PROFILE(44, pfnEach(t60, t59, pfnSum));
    PROFILE(45, pfnRaze(t61, t60));
    PROFILE(46, pfnEachRight(t62, t40, t44, pfnIndex));
    PROFILE(47, pfnEach(t63, t62, pfnSum));
    PROFILE(48, pfnRaze(t64, t63));
    PROFILE(49, pfnEachRight(t68, t25, t44, pfnIndex));
    PROFILE(50, pfnEach(t69, t68, pfnAvg));
    PROFILE(51, pfnRaze(t70, t69));
    PROFILE(52, pfnEachRight(t71, t27, t44, pfnIndex));
    PROFILE(53, pfnEach(t72, t71, pfnLen));
    PROFILE(54, pfnRaze(t73, t72));
    PROFILE(55, pfnList(t74, 2, (V []){t45, t46}));
    PROFILE(56, pfnOrderBy(t75, t74, LiteralVectorBool(2, (B []){1, 1})));
    PROFILE(57, pfnIndex(t76, t45, t75));
    PROFILE(58, pfnIndex(t77, t46, t75));
    PROFILE(59, pfnIndex(t78, t49, t75));
    PROFILE(60, pfnIndex(t79, t55, t75));
    PROFILE(61, pfnIndex(t80, t61, t75));
    PROFILE(62, pfnIndex(t81, t64, t75));
    PROFILE(63, pfnIndex(t82, t52, t75));
    PROFILE(64, pfnIndex(t83, t58, t75));
    PROFILE(65, pfnIndex(t84, t70, t75));
    PROFILE(66, pfnIndex(t85, t73, t75));
    PROFILE(67, copyV(t86,LiteralVectorSymbol(10, (S []){"l_returnflag", "l_linestatus", "sum_qty", "sum_base_price", "sum_disc_price", "sum_charge", "avg_qty", "avg_price", "avg_disc", "count_order"})));
    PROFILE(68, pfnList(t87, 10, (V []){t76, t77, t78, t79, t80, t81, t82, t83, t84, t85}));
    PROFILE(69, pfnTable(t88, t86, t87));
    h_rtn[0] = t88;
    return 0;
}

E horse_entry(){
    V rtns[99];
    tic();
    HORSE_UDF(0, horse_main(rtns), {});
    E elapsed = calc_toc();
    P("The elapsed time (ms): %g\n", elapsed);
    P("Output:\n");
    DOI(1, printV2(rtns[i],20))
    return elapsed;
}

// Compiling time (ms): 0.493
