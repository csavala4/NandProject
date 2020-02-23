// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// KBD and SCREEN are predefined to refer to RAM addresses and 24576 (0x6000), 16384 (0x4000)

// To fill the screen or clear it, we need to cycle 32*256 words 
// 32 comes from the 32 rows of 16-bit pixels.
// 32*256 words and write 0/-1 to each of them
// -1 is because -1 in two's complement turns all values to 1

//Set scr_curr_position pointer to SCREEN
@SCREEN
D=A
@scr_curr_position
M=D
//Set screen value size to 32*256
@8192
D=A
@SCREEN
D=D+A //sets SCREEN D-REG to 8192+16384
@max_position
M=D //sets max posiiton REG to SCREEN value 

(BEGIN)
	@KBD  
	D=M
	@WHT
	D;JEQ //Jump to WHT if no key is pressed 
	@BLK
	0;JMP //Jump to BLK otherwise

(BLK)
	@scr_curr_position
	A=M
	M=-1 //Set the value of current screen position to -1(All black).
	@INCR
	0;JMP //Increment the pointer to next position.

(WHT)
	@scr_curr_position
	A=M
	M=0 //Set the vlaue of current screen position to 0(All white).
	@INCR
	0;JMP //Increment the pointer to next position.

(INCR)
	@scr_curr_position
	D=M+1
	M=D
	
	@max_position
	D=D-M //max position = screen current position - max position
	@BEGIN
	D;JNE // If max pos and current pos not equal, reset

	@SCREEN
	D=A
	@scr_curr_position
	M=D
	@BEGIN
	0;JMP // otherwise, reset screen current position memory register
