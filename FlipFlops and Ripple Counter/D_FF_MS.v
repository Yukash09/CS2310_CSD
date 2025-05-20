module D_a(input d , input en , input rstn , output reg q);
    always @(en , d , rstn)
    begin
            if(!rstn) q <= 0 ;
            else
            if(en)
                q <= d;
    end
endmodule

module D_FF_MS(input D , input CLK , output Q);
    wire a1 ; wire a2 ;
    not(a2 , CLK);
    D_a d1(D , CLK , 1 , a1);
    D_a d2(a1 , a2 , 1 , Q);
endmodule