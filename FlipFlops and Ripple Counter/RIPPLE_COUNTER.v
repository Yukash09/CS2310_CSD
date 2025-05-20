module D_b(input d , input en , input rstn ,output q);
    wire t1 , t2 , t3 , t4  ;
    // nand(t1 , d , en) ;
    // not(t2 , d) ;
    // nand(t3 , t2 , en) ;
    // nand(t4 , t1 , q_) ;
    // nand(t5 , t3 , q);
    // and(q , t4 , rstn);
    // and(q_ , t5 , ~rstn);
    and(t1 , en , d);
    and(t2 , t4 , q) ;
    or(t3 , t2 , t1);
    and(q , rstn , t3);
    not(t4 , en);
endmodule

module D_FF_MS(input D , input CLK , input rst , output Q);
    wire a1 ; wire a2 ;
    not(a2 , CLK);
    D_b d1(D , CLK , rst , a1);
    D_b d2(a1 , a2 , rst , Q);
endmodule

module RIPPLE_COUNTER(input CLK , input RESET , output [3:0] COUNT) ;
    wire t1 , t2 , t3 , t4  , CLK_ , rst_;
    not(t1 , COUNT[0]);
    not(t2 , COUNT[1]) ;
    not(t3 , COUNT[2]) ;
    not(t4 , COUNT[3]) ;
    not(CLK_ , CLK) ;
    not(rst_ , RESET) ;
    // assign COUNT[0] = 0 ;
    D_FF_MS r1(t1 , CLK_ , rst_ , COUNT[0]) ;
    D_FF_MS r2(t2 , COUNT[0] , rst_ , COUNT[1]) ;
    D_FF_MS r3(t3 , COUNT[1] , rst_ ,COUNT[2]) ;
    D_FF_MS r4(t4 , COUNT[2] , rst_ , COUNT[3]) ;
endmodule