`timescale 1ns/1ns
module tb_muls8;
    reg   [7:0] a,b;
    wire [15:0] y;
    muls8 M(a,b,y);
    initial begin
        $dumpfile ("muls8.vcd");
        $dumpvars (0,muls8);
        $monitor ("At ",$time, ": A=%d, B=%d, Y=%d",a,b,y);
            a  = 8'hff; b  = 8'hff;
        #10 a  = 8'h7f; b  = 8'h7f;
        #10 a  = 8'h81; b  = 8'h81;
        #10 a  = 8'h7e; b  = 8'h7e;
        #10 a  = 8'h82; b  = 8'h82;
        #10 a  = 8'h7d; b  = 8'h7d;
        #10 a  = 8'h83; b  = 8'h83;
        #10 a  = 8'h7e; b  = 8'h81;
        #10 a  = 8'h82; b  = 8'h7d;
        #10 $finish;
   end
endmodule
