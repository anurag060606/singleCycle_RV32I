module data_memory (
    input [31:0] A, WD,
    input clk, WE, rst_n,
    output [31:0]RD
);

//stores the variables that are going to be used by the cpu
//data to be used by cpu is read from register file 
//data from data_memory goes to register_file which is used by cpu 


    reg [31:0] data_memory_reg [1023:0];
    //synchronous write 
    //but all reads we did till now were asynchronous 
    //because state elements change their state only on clock edge the entire processor is synchronous sequential circuit
    always @(posedge clk) begin
        if(WE) begin
            data_memory_reg[A] <= WD; 
        end
    end

    assign RD=(~rst_n)? 32'd0 : data_memory_reg[A];

    initial begin
        //data_memory_reg[28] = 32'h00000020;
        //mem[40] = 32'h00000002;

        data_memory_reg[28]=32'd20;

        data_memory_reg[36]=32'd12;

    end
  
endmodule
