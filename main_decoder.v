module main_decoder(Op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, Branch );
    //main decoder only looks at the opcode
    //based on opcode it classifies instructions as arithemetic instruction 
    //or load instruction or store instruction or branch instruction 
    //if result of an arithmetic isntruction is to be stored in x5, there must be a flag to indicate so that is the job of RegWrite
    //MemWrite when writing to the memory, the signals goes high
    //ALUSrc decides where the input to other register comes from, is it a vairable stored in some other register or is it an immediate value
     //ALUOp if the opcode is same, ALUOp says ask someone for exact operation
     //the aluu decoder then checks funct3 and 7 to determine the exact option

    input [6:0]Op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc,ALUOp;

    assign RegWrite = (Op == 7'b0000011 || Op == 7'b0110011) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
                    (Op == 7'b1100011) ? 2'b10 :    
                                         2'b00 ;
    assign ALUSrc = (Op == 7'b0000011 || Op == 7'b0100011) ? 1'b1 :
                                                            1'b0 ;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
                                            1'b0 ;
    assign Branch = (Op == 7'b1100011) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                   (Op == 7'b1100011) ? 2'b01 :
                                        2'b00 ;

endmodule