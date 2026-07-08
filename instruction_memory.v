module instruction_memory (
    input [31:0] A,
    input rst_n,
    output [31:0]RD
);
//this module has all the instructions stored in itself
//if you wanna read a instruction, just give the address of the instruction as A and RD outputs the instruction


    reg [31:0] mem [1023:0];

    assign RD= (rst_n==1'b0)? 32'h0000_0000: mem[A[31:2]];
    //since memory is bite addressable i.e. address locations go like 1000 1004 1008... 
    //you need to initialixe the instructions here already, you cannot put instructions in this module in any other way it must be stored beforehand
    initial begin
       // mem[0]=32'hFFC4A303;
       //mem[0]=32'h0064A423;
       //mem[0]=32'h0062E233;


        mem[0]=32'hFFC4A303;

        mem[1]=32'h0044A383;

        mem[2]=32'h00730433;

        mem[3]=32'h40730533;

        mem[4]=32'h007375B3;

        mem[5]=32'h00736633;

        mem[6]=32'h0063A6B3;

        mem[7]=32'h0084A423;

        mem[8]=32'h00A40733;

        mem[9]=32'h00E4A623;

    end
    
endmodule