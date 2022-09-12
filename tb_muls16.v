`timescale 1ns/1ns
module tb_muls16;
    reg signed [15:0] a,b;
    wire signed [31:0] y;
    muls16 M(a,b,y);
    initial begin
        $dumpfile ("muls16.vcd");
        $dumpvars (0,muls16);
        $monitor ("At ",$time, ": A=%d, B=%d, Y=%d",a,b,y);
            a  = -16'd25; b  = 16'd25;
        #10 a  =  16'd32; b  = 16'd32;
        #10 a  =  -16'd24; b  = 16'd10;
        #10 a  = -16'd32; b  = 16'd32;
        #10 a  = -16'd125;b  = 16'd8;
        #10 a  = 16'd1001;b  = 16'd831;
        #10 a  =  -16'd17;b  = 16'd13;
        #10 a  =   16'd17;b  = 16'd13;
        #10 $finish;
   end
endmodule
