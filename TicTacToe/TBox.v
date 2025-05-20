module TCell(input clk , set , reset , set_symbol , output reg valid , symbol);
    initial begin
        valid = 0 ;
    end
    always @(posedge clk) begin
        if(reset) begin
             symbol <= 0 ;
             valid <= 0 ;
        end
        else begin
            if(set)
                if(!valid) begin
                symbol <= set_symbol ;
                valid <= 1 ;
                end
        end
    end    
endmodule

module rcdecode(input [1:0] row , input [1:0] col  , output reg [3:0] o) ;
    always @(*) begin
        o = 0 ;
        case(row)
            2'b01: begin
                case(col)
                    2'b01: o = 0 ;
                    2'b10: o = 1 ;
                    2'b11: o = 2 ;
                endcase
            end
            2'b10: begin
                case(col)
                    2'b01: o = 3 ;
                    2'b10: o = 4 ;
                    2'b11: o = 5 ;
                endcase
            end
            2'b11: begin
                case(col)
                    2'b01: o = 6 ;
                    2'b10: o = 7 ;
                    2'b11: o = 8 ;
                endcase
            end
            default: o = 0 ;
        endcase
    end
endmodule

module setter(input [3:0] c , input set , input [1:0] gstate , output reg [8:0] v);
    always @(*) begin
        v = 0 ;
        if(set && !gstate) begin
            v[c] = 1 ;
        end
    end
endmodule

// module cel(input clk , reset , player , input[8:0] valid , input[8:0] v, input [8:0]symbol) ;
//     TCell t1(clk , v[0] , reset , player , valid[0] , symbol[0]);
//     TCell t2(clk , v[1] , reset , player , valid[1] , symbol[1]);
//     TCell t3(clk , v[2] , reset , player , valid[2] , symbol[2]);
//     TCell t4(clk , v[3] , reset , player , valid[3] , symbol[3]);
//     TCell t5(clk , v[4] , reset , player , valid[4] , symbol[4]);
//     TCell t6(clk , v[5] , reset , player , valid[5] , symbol[5]);
//     TCell t7(clk , v[6] , reset , player , valid[6] , symbol[6]);
//     TCell t8(clk , v[7] , reset , player , valid[7] , symbol[7]);
//     TCell t9(clk , v[8] , reset , player , valid[8] , symbol[8]);
// endmodule

module switch(input [8:0] valid, output player) ;
    assign player = 1 ^ valid[0] ^ valid[1] ^ valid[2] ^ valid[3] ^ valid[4] ^ valid[5] ^ valid[6] ^ valid[7] ^ valid[8] ;
endmodule

module TBox(input clk , set , reset , input [1:0] row , input [1:0] col , output [8:0] valid , output [8:0] symbol , output[1:0] game_state) ;

    wire player ;
    wire reg [3:0] c ;
    wire [8:0] v ;   
    reg [8:0] gstate ;

    TCell t1(clk , v[0] , reset , player , valid[0] , symbol[0]);
    TCell t2(clk , v[1] , reset , player , valid[1] , symbol[1]);
    TCell t3(clk , v[2] , reset , player , valid[2] , symbol[2]);
    TCell t4(clk , v[3] , reset , player , valid[3] , symbol[3]);
    TCell t5(clk , v[4] , reset , player , valid[4] , symbol[4]);
    TCell t6(clk , v[5] , reset , player , valid[5] , symbol[5]);
    TCell t7(clk , v[6] , reset , player , valid[6] , symbol[6]);
    TCell t8(clk , v[7] , reset , player , valid[7] , symbol[7]);
    TCell t9(clk , v[8] , reset , player , valid[8] , symbol[8]);
    rcdecode r1(row , col , c); 
    setter st1(c , set , game_state , v);
    switch sw1(valid , player) ;
    // assign player = player ^ 1 ;
    // always @(*) begin
    //      player = player ^ 1 ; 
    // end


    always @(*) begin
        gstate = 2'b00 ;
        if(symbol[0] & symbol[1] & symbol[2] & valid[0] & valid[1] & valid[2]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[0] & ~symbol[1] & ~symbol[2] & valid[0] & valid[1] & valid[2]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[0] & symbol[3] & symbol[6] & valid[0] & valid[3] & valid[6]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[0] & ~symbol[3] & ~symbol[6] & valid[0] & valid[3] & valid[6]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[3] & symbol[4] & symbol[5] & valid[3] & valid[4] & valid[5]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[3] & ~symbol[4] & ~symbol[5] & valid[3] & valid[4] & valid[5]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[1] & symbol[4] & symbol[7] & valid[1] & valid[4] & valid[7]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[1] & ~symbol[4] & ~symbol[7] & valid[1] & valid[4] & valid[7]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[2] & symbol[5] & symbol[8] & valid[2] & valid[5] & valid[8]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[2] & ~symbol[5] & ~symbol[8] & valid[2] & valid[5] & valid[8]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[6] & symbol[7] & symbol[8] & valid[6] & valid[7] & valid[8]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[6] & ~symbol[7] & ~symbol[8] & valid[6] & valid[7] & valid[8]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[0] & symbol[4] & symbol[8] & valid[0] & valid[4] & valid[8]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[0] & ~symbol[4] & ~symbol[8] & valid[0] & valid[4] & valid[8]) begin
            gstate = 2'b10 ;
        end
        else if(symbol[2] & symbol[4] & symbol[6] & valid[4] & valid[6] & valid[2]) begin
            gstate = 2'b01 ;
        end
        else if(~symbol[2] & ~symbol[4] & ~symbol[6] & valid[4] & valid[6] & valid[2]) begin
            gstate = 2'b10 ;
        end
        else if(valid[0] & valid[1] & valid[2] & valid[3] & valid[4] & valid[5] & valid[6] & valid[7] & valid[8]) begin
            gstate = 2'b11 ;
        end
    end
    assign game_state = gstate ;
        
endmodule
