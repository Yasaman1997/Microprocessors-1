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

