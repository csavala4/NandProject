// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


@R2
    M=0 //initialize RAM[2] to 0

(LOOP)
    @R1
		D=M 
	@R0
		D=D-M
    @LOOPR0
		D;JGT //jump to LOOPR0 if R1 > R0
	@R1
		D=M 
	@END
		D;JEQ //jump to END if value of RAM[1] = 0
    @R1
		D=A
		M=M-D //Set value of RAM[1] to Mem value - Addr value
    @R0
		D=M
    @R2
		M=M+D //Sum RAM[2] = Current val RAM[2] + val RAM[0]
    @LOOP
		0;JMP //Loop back to LOOP

(LOOPR0) 
	@R0
		D=M
	@END
		D;JEQ // jump to END if value of RAM[0] = 0
	@R0
		D=A+1
		M=M-D //Set value of RAM[0] to Mem value - (Addr - 1)value
	@R1
		D=M
	@R2
		M=M+D //Sum RAM[2] = Current val RAM[2] + val RAM[1]
	@LOOPR0
		0;JMP //Loop back to LOOPR0
(END)
    @END
		0;JMP //End program with infinite loop
