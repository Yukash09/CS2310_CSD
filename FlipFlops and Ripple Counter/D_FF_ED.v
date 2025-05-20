module D_a(input d , input en , input rstn , output reg q);
    always @(en , d , rstn)
    begin
            if(!rstn) q <= 0 ;
            else
            if(en)
                q <= d;
    end
endmodule

module D_FF_ED(input D , input CLK , output Q);
    wire a2 ; wire pos ;
    wire a1 ; wire a3 ;
    not(a1 , a2);
    and(pos , CLK , a1);
    not(a3 , pos);
    D_a d1(D , a3 , 1 , Q);
endmodule