module alu (
    input [31:0] A,B,
    input [2:0] ALUControl,

    output [31:0] result,
    output  Zero, Negative, Carry ,Overflow //0 flag, negative fl
);

    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire cout;
    wire [31:0]slt;

    wire [31:0] mux_1;
    wire [31:0] mux_2;
    wire [31:0] sum;

    assign a_and_b= A & B;
    assign a_or_b= A  | B;

    assign not_b= ~B;

    assign mux_1= (ALUControl[0]==1'b0) ? B:not_b;

    assign {cout,sum} = A+mux_1+ALUControl[0];
    assign mux_2=(ALUControl[2:0]==3'b000) ? sum: //for load word and store word, to compute the address of the register -> lw x6, 8(x5); sw x7, 8(x5)
                (ALUControl[2:0]==3'b001) ? sum: //subtraction- subtraction is just addition with two's complement
                (ALUControl[2:0]==3'b010) ? a_and_b: //010 stands for AND
                (ALUControl[2:0]==3'b011) ? a_or_b: //011 stands for or 
                (ALUControl[2:0]==3'b101) ? slt: 32'h0000_0000; //101 stands fro slt explanation given 
                //slt is set less than 
                //assembly : slt rd, rs1, rs2
                //logic - if rs1<rs2 
                //              => rd=1 
                //        else rd=0
                //              =>rd=0;
                //instead of using a comparator computers compute A-B
                //if A-B<0 then A<B and rd=1 else if A-B>0 rd=0;
    
    assign result=mux_2;
    assign Zero= &(~result);
    assign Negative=result[31];
    assign  Carry=cout& ~(ALUControl[1]);
    assign Overflow= (~(ALUControl[1]) & (A[31] ^ sum[31])) & (~(A[31]^B[31]^ALUControl[0]));
    
    wire slt_bit;
    assign slt_bit = sum[31] ^ Overflow;
    assign slt = {31'd0, slt_bit};

endmodule 