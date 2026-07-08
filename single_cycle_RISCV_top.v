module single_cycle_RISCV_top(
    input clk, rst_n

);

wire [31:0] PC_next, PC_out,instruction, extended_immediate, register_file_out_RD1,ALU_result_out,data_memory_out_RD,register_file_out_RD2, SrcB_wire,finalMux_out;
wire [2:0] ALUControl_wire;
wire RegWrite_wire, MemWrite_wire, ALUSrc_wire, ResultSrc_wire;
wire [1:0]ImmSrc_wire;


pc_adder dut_pc_adder(
    .a(PC_out),
    .b(32'd4),
    .c(PC_next)
);

program_counter dut_program_counter (
    .clk(clk),
    .rst_n(rst_n),
    .PC_next(PC_next),
    .PC(PC_out)
);

instruction_memory dut_instruction_memory(
    .A(PC_out),
    .rst_n(rst_n),
    .RD(instruction)
);
sign_extend dut_sign_extend(
    .ImmSrc(ImmSrc_wire[0]),
    .imm_extd_in(instruction),
    .imm_extd_out(extended_immediate)    
);
register_file dut_register_file (
    .A1(instruction[19:15]),
    .A2(instruction[24:20]),
    .A3(instruction[11:7]),
    .WD3(finalMux_out),
    .WE3(RegWrite_wire),
    .clk(clk),
    .rst_n(rst_n),
    .RD1(register_file_out_RD1),
    .RD2(register_file_out_RD2)
);

mux mux_registerFile2ALU (
    .a(register_file_out_RD2),
    .b(extended_immediate),
    .c(SrcB_wire),
    .s(ALUSrc_wire)
);

alu dut_alu(
    .A(register_file_out_RD1),
    .B(SrcB_wire),
    .ALUControl(ALUControl_wire),
    .result(ALU_result_out),
    .Zero(),
    .Negative(), 
    .Carry(),
    .Overflow() 
);

control_unit_top dut_control_unit_top(
    .Op(instruction[6:0]),
    .RegWrite(RegWrite_wire),
    .ImmSrc(ImmSrc_wire),
    .ALUSrc(ALUSrc_wire),
    .MemWrite(MemWrite_wire),
    .ResultSrc(ResultSrc_wire),
    .Branch(),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .ALUControl(ALUControl_wire)
);

data_memory dut_data_memory(
    .A(ALU_result_out), 
    .WD(register_file_out_RD2),
    .clk(clk), 
    .WE(MemWrite_wire),
    .rst_n(rst_n),
    .RD(data_memory_out_RD)
);

mux finalMux (
    .a(ALU_result_out),
    .b(data_memory_out_RD),
    .c(finalMux_out),
    .s(ResultSrc_wire)
);



endmodule