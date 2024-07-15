module ControlUnit(
        input [5:0] FUNCT,
        input [5:0] OPCODE,
        input ZERO, // de la ALU
        output reg REG_DST,
        output reg REG_WRITE,
        output reg EX_TOP,
        output reg ALU_SRC,
        output reg [3:0] ALU_OP,
        output reg MEM_WRITE,
        output reg MEM2REG
);

    always@(FUNCT or OPCODE)
    if(OPCODE == 6'b0) // R-TYPE
        case(FUNCT)
            6'b100_000 : {REG_DST, REG_WRITE, EX_TOP, ALU_SRC, ALU_OP, MEM_WRITE, MEM2REG} = 10'b1_1_0_0_0010_0_1;
//            6'b100_010:
        endcase
    else if(OPCODE == 6'b001_000)
        {REG_DST, REG_WRITE, EX_TOP, ALU_SRC, ALU_OP, MEM_WRITE, MEM2REG} = 10'b0_1_0_1_0010_0_1;

endmodule

/*

R-TYPE
        FUNC    -> OPCODE = 0
ADD   100_000
SUB   100_010
AND   100_100
OR    100_101
SLT   101_010

opcode (6) | r1 (5) | r2 (5) | rd (5) | shamt (5) | funct (6)

shamt - numbers of bits for shifting (shift instrunctions only)
funct - specify the exact function (add, sub etc)

RegDst - 1 (select rd as desination register)
RegWrite - 1 (activate the writing to the register)
AluSrc - 0 (for R instructions the operands come from -R-egisters)
ExTop, MemWrite - 0 (we dont use ExTop for R type and R type dont write to memory)
Mem2Reg - 1 (the data to be written is coming from ALU, not data memory)

I-TYPE
        OPCODE
ADDi  001_000
LHi   011_001
LOi   011_000

opcode (6) | r (5) | rd (5) | immediate (16)

RegDst - 0 (uses the same register for destination)
RegWrite - 1 (activate the writing to the register)
AluSrc - 1 (for I instructions the operands come from SignExtended Immediates)
ExTop - 1 or 0 
MemWrite - 0 (not for addi)
Mem2Reg - 1 (the data to be written is coming from ALU, not data memory)



*/