# Basic Single Cycle Data Path Processor

Authors: [Xiaotian Shi](https://github.com/xshi1012), [Yifeng Zhang](https://github.com/yiz569), [Sihan Sun](https://github.com/SihanSun)

## Description
This project contains the SystemVerilog code for a simple single cycle data path processor and its assembler, as well as three programs that could be run on this processor (assembly codes of the programs can be found in the assember/ folder). The assembler is written in Python.

## ISA
The prcessor uses a 9-bit ISA. 10 instructions, 8 registers are supported.
#### Instructions
| Instruction | opcode |  func | syntax | result |
| ----------- |--------|-------|--------|--------|
| add | 000 | N/A | add rd rs | rd = rd + rs |
| mov | 001 | N/A | mov rd imm | rd = imm |
| csl | 010 | 1 | csl rd imm | rd = rd << imm |
| csr | 010 | 0 | csr rd imm | rd = rd >> imm |
| lw | 011 | N/A | lw rd rs | rd = 0(rs) |
| sw | 100 | N/A | sw rs rd | 0(rd) = rs |
| xor | 101 | N/A | xor rd rs | rd = rd ^ rs |
| and | 110 | N/A | and rd rs | rd = rd & rs |
| bne | 111 | N/A | bne rd rs | branch if rd != rs |
| halt | 010 | 0 | halt | PC will halt |

**Note:** 
1. The third bit (from the right) is considered the func bit for shift operations. The max shift amount is 4.
2. *csl* and *csr* are circular shifts
3. *halt* has the same opcode as shifts, but rd and imm should be 0. (shifting r0 by 0 means halt)
4. *bne* does not take in label as operand. Instead, if the branch is taken, the next line will be interpreted as an index (which label it is) into the lookup table which gives the address of the label.
5. The ISA supports at most 64 labels.

## Assembler
The input to the assembler should contain no comments, no empty lines, and no commas. The operands and the operations should be separated by spaces. Label should appear at the same line as the next instruction.

**Examples:**
1. `add r0 r1`
2. `branch1: mov r0 0`

A helper python file `format.py` is written to help format assembly code into formats that the assembler accepts.

**Assembler Usage:**
1. Use `python format.py formatted_output_filename input_filename` to format assembly code
2. Use `python assembler.py output_file_name input_file_name` to compile assembly code

Lookup table entries will be save to `lookup_table.txt`