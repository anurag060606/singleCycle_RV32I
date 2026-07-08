# Single-Cycle RISC-V Processor

A synthesizable 32-bit single-cycle RISC-V processor implemented in Verilog. Every instruction is completed within a single clock cycle, making the design simple and suitable for learning processor architecture and digital design.

## Features
- 32-bit RISC-V RV32I subset
- Single-cycle datapath
- Separate instruction and data memories
- Modular RTL design
- Synthesizable Verilog implementation

## Supported Instructions
- **R-Type:** `add`, `sub`, `and`, `or`, `slt`
- **I-Type:** Arithmetic and load instructions
- **S-Type:** Store instructions
- **B-Type:** Conditional branch instructions

## Main Modules
- Program Counter (PC)
- Instruction Memory
- Register File
- Control Unit
- Immediate Generator
- ALU
- Data Memory
- Multiplexers

## Processor Flow
1. Instruction Fetch
2. Instruction Decode
3. Execute
4. Memory Access
5. Write Back

> All five operations are completed within a single clock cycle for each instruction.

## Tools Used
- Icarus Verilog HDL
- GTKWave (for simulation)
