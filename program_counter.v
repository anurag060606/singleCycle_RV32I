module program_counter
(
    input [31:0] PC_next,
    input clk, rst_n,
    output reg [31:0] PC
);

    always @(posedge clk) begin
        if(rst_n==0) begin
            PC<=32'h0000_0000;
        end else begin
            PC<=PC_next;
        end
    end
    
endmodule