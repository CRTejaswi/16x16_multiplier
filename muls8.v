/* module muls8 (a,b,y); */
/*     input   [7:0] a, b; */
/*     output [15:0] y; */
/*     wire    [7:0] ab0 = a & {8{b[0]}}; */
/*     wire    [7:0] ab1 = a & {8{b[1]}}; */
/*     wire    [7:0] ab2 = a & {8{b[2]}}; */
/*     wire    [7:0] ab3 = a & {8{b[3]}}; */
/*     wire    [7:0] ab4 = a & {8{b[4]}}; */
/*     wire    [7:0] ab5 = a & {8{b[5]}}; */
/*     wire    [7:0] ab6 = a & {8{b[6]}}; */
/*     wire    [7:0] ab7 = a & {8{b[7]}}; */

/*     assign y = (({8'b1,~ab0[7], ab0[6:0]} */        
/*                + {7'b0,~ab1[7], ab1[6:0],1'b0}) */
/*                +({6'b0,~ab2[7], ab2[6:0],2'b0} */
/*                + {5'b0,~ab3[7], ab3[6:0],3'b0})) */
/*               +(({4'b0,~ab4[7], ab4[6:0],4'b0} */
/*                + {3'b0,~ab5[7], ab5[6:0],5'b0}) */
/*                +({2'b0,~ab6[7], ab6[6:0],6'b0} */
/*                + {1'b1, ab7[7],~ab7[6:0],7'b0})); */

/* endmodule */

`timescale 1ns/1ns
module muls8 (a,b,y);
    input   [7:0] a, b;
    output [15:0] y;
    wire    [7:0] ab0 = a & {8{b[0]}};
    wire    [7:0] ab1 = a & {8{b[1]}};
    wire    [7:0] ab2 = a & {8{b[2]}};
    wire    [7:0] ab3 = a & {8{b[3]}};
    wire    [7:0] ab4 = a & {8{b[4]}};
    wire    [7:0] ab5 = a & {8{b[5]}};
    wire    [7:0] ab6 = a & {8{b[6]}};
    wire    [7:0] ab7 = a & {8{b[7]}};

    // layer 1
    wire [16:0] s1,c1;
    half_adder h11(s1[1],c1[1],ab0[1],ab1[0]);
    full_adder f11(s1[2],c1[2],ab0[2],ab1[1],ab2[0]);
    full_adder f12(s1[3],c1[3],ab0[3],ab1[2],ab2[1]);
    full_adder f13(s1[4],c1[4],ab0[4],ab1[3],ab2[2]);
    full_adder f14(s1[5],c1[5],ab0[5],ab1[4],ab2[3]);
    full_adder f15(s1[6],c1[6],ab0[6],ab1[5],ab2[4]);
    full_adder f16(s1[7],c1[7],ab0[7],ab1[6],ab2[5]);
    half_adder h12(s1[8],c1[8],      ab1[7],ab2[6]);
    

    half_adder h13 (s1[9], c1[9], ab3[1],ab4[0]);
    full_adder f17 (s1[10],c1[10],ab3[2],ab4[1],ab5[0]);
    full_adder f18 (s1[11],c1[11],ab3[3],ab4[2],ab5[1]);
    full_adder f19 (s1[12],c1[12],ab3[4],ab4[3],ab5[2]);
    full_adder f110(s1[13],c1[13],ab3[5],ab4[4],ab5[3]);
    full_adder f111(s1[14],c1[14],ab3[6],ab4[5],ab5[4]);
    full_adder f112(s1[15],c1[15],ab3[7],ab4[6],ab5[5]);
    half_adder h14 (s1[16],c1[16],      ab4[7],ab5[6]);

    // layer 2
    wire [16:0] s2,c2;
    half_adder h21(s2[1],c2[1],c1[1],s1[2]);
    full_adder f22(s2[2],c2[2],c1[2],s1[3],ab3[0]);
    full_adder f23(s2[3],c2[3],c1[3],s1[4],s1[9]);
    full_adder f24(s2[4],c2[4],c1[4],s1[5],c1[9]);
    full_adder f25(s2[5],c2[5],c1[5],s1[6],c1[10]);
    full_adder f26(s2[6],c2[6],c1[6],s1[7],c1[11]);
    full_adder f27(s2[7],c2[7],c1[7],s1[8],c1[12]);
    full_adder f28(s2[8],c2[8],c1[8],ab2[7],c1[13]);

    half_adder h22 (s2[9],c2[9],s1[11],ab6[0]);
    full_adder f29 (s2[10],c2[10],s1[12],ab6[1],ab7[0]);
    full_adder f210(s2[11],c2[11],s1[13],ab6[2],ab7[1]);
    full_adder f211(s2[12],c2[12],s1[14],ab6[3],ab7[2]);
    full_adder f212(s2[13],c2[13],s1[15],ab6[4],ab7[3]);
    full_adder f213(s2[14],c2[14],s1[16],ab6[5],ab7[4]);
    full_adder f214(s2[15],c2[15],ab5[7],ab6[6],ab7[5]);
    half_adder h23 (s2[16],c2[16],      ab6[7],ab7[6]);


    // layer 3

    wire [10:0] s3,c3;
    half_adder h31(s3[1],c3[1],c2[1],s2[2]);
    half_adder h32(s3[2],c3[2],c2[2],s2[3]);
    full_adder f31(s3[3],c3[3],c2[3],s2[4],s1[10]);
    full_adder f32(s3[4],c3[4],c2[4],s2[5],s2[9]);
    full_adder f33(s3[5],c3[5],c2[5],s2[6],c2[9]);
    full_adder f34(s3[6],c3[6],c2[6],s2[7],c2[10]);
    full_adder f35(s3[7],c3[7],c2[7],s2[8],c2[11]);
    full_adder f36(s3[8],c3[8],c2[8],c1[14],c2[12]);
    half_adder h33(s3[9],c3[8]     ,c1[15],c2[13]);
    half_adder h34(s3[10],c3[8]    ,c1[16],c2[14]);

    // layer 4
    wire [11:0] s4,c4;
    half_adder h41(s4[1],c4[1],c3[1],s3[2]);
    half_adder h42(s4[2],c4[2],c3[2],s3[3]);
    half_adder h43(s4[3],c4[3],c3[3],s3[4]);
    full_adder f41(s4[4],c4[4],c3[4],s3[5],s2[10]);
    full_adder f42(s4[5],c4[5],c3[5],s3[6],s2[11]);
    full_adder f43(s4[6],c4[6],c3[6],s3[7],s2[12]);
    full_adder f44(s4[7],c4[7],c3[7],s3[8],s2[13]);
    full_adder f45(s4[8],c4[8],c3[8],s3[9],s2[14]);
    full_adder f46(s4[9],c4[9],c3[9],s3[10],s2[15]);
    full_adder f47(s4[10],c4[10],c3[10],c2[15],s2[16]);
    half_adder h44(s4[10],c4[10]       ,c2[16],ab7[7]);

    // addition layer and assessment

    assign y[0] = ab0[0];
    assign y[1] = s1[1];
    assign y[2] = s2[1];
    assign y[3] = s3[1];
    assign y[4] = s4[1];
    assign y[15:5] = {c4[11:1]}+{1'b0,s4[11:2]};

endmodule

`timescale 1ns/1ns
module half_adder (
    output sum,cout,
    input a,b
);
    xor x1(sum,a,b);
    and a1(cout,a,b);
endmodule

`timescale 1ns/1ns
module full_adder (
    output sum,cout,
    input a,b,cin
);
    wire s1,c1,c2;
    half_adder h1(s1,c1,a,b);
    half_adder h2(sum,c2,s1,cin);
    or o1(c1,c2);
endmodule
