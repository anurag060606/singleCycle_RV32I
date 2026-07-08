module register_file (
    input [4:0] A1, A2, A3,
    //A1, A2 are source operands, and can access any of the 32 registers on riscv these are the read porsts
    //A3 is the write port 
    input [31:0] WD3,
    //WD3 takes the write data input 
    //WE3 is the write enable 
    input WE3,
    input clk, rst_n,
    output [31:0]RD1, RD2
    //
);
    //creating memory
    reg [31:0] registers [31:0];
    assign RD1= (!rst_n)? 32'h0000_0000 : registers[A1];
    assign RD2= (!rst_n)? 32'h0000_0000 : registers[A2];

    always @(posedge clk) begin
        if(WE3)begin
            registers[A3] <= WD3;
        end
    end

    initial 
    begin
        //registers[9]=32'h00000020;
        //registers[6]=32'h000002f0;
        // registers[5]=32'h00000006;
        // registers[6]=32'h0000000A;
        registers[9]=32'd32;
    end
endmodule