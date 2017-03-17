;
; ADDITION_SQUARE_5X.asm
;
; Created: 3/17/2017 8:50:57 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
adder_subroutine:
	/* The number n must be stored in R10 according to the problem definition */ 
	ldi R10,25
	/* Make a copy of R10 in the R9 */ 
	/* R9 is to check the end of the loop */
	mov R9,R10

	/* Check if we have reached the n */
	cp R9,R10
	brne adder_subroutine

  rjmp start
