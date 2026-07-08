module sign_extend (
    input [31:0] imm_extd_in,
    input ImmSrc,
    output [31:0] imm_extd_out
);
    assign imm_extd_out= (ImmSrc == 1'b1) ? 
                                            ({{20{imm_extd_in[31]}},imm_extd_in[31:25],imm_extd_in[11:7]}):
                                            {{20{imm_extd_in[31]}},imm_extd_in[31:20]};

endmodule