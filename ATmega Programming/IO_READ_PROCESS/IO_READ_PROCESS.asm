;
; IO_READ_PROCESS_ASSEMBLY.asm
;
; Created: 3/20/2017 9:58:25 AM
; Author : Ali Gholami
;


; Replace with your application code
start:
	/* Call a subroutine to read from IO */
	call IO_READ_SUB
    rjmp start

IO_READ_SUB:
	/* Grab the data from IO Address: 0x25 */
	/* Put it in the R5 in register file */
	in R5,0x25

	/* Processing Section: 1- Swapping the nibbles
	* This will make the following change:
	* R(7:4) ← Rd(3:0), R(3:0) ← Rd(7:4) */
	swap R5

	/* Clear the bit 3 in the register R5 */
	/* We can simply use the CBR instruction 
	* This is how CBR works: 
	* Clears the specified bits in register Rd. Performs the logical AND
	* between the contents of register Rd and the complement of the constant mask K.
	* The result will be placed in register Rd. */ 
	/* So the mask should be 00001000 to make the bit number 3 cleared */
	CBR R5,8

