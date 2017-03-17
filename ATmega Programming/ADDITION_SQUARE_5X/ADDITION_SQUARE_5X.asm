;
; ADDITION_SQUARE_5X.asm
;
; Created: 3/17/2017 8:50:57 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
adder_subroutine:
	.def n,25
	/* The number n must be stored in R10 according to the problem definition */ 
	ldi R10,n
	/* Find the square of the number */ 
	/* R7 will start this procedure from 0 and will be added 5 more each time */
	ldi R7,0
	/* Sqaure the R7 and put the result in R1:R0(mul does this by default) */
	mul R7,R7
	/* add the result to the R4:R3 (we need addition! not replacement :D) */
	add R3,R0
	adc R4,R1			
	/* We need to use R6 with R7 as a pair(since ADIW will put the result in a pair) */
	/*ldi R6,0 (shame) */
	/* Add immediate 5 to the word R7:R6 (because we need the sqaure of 5X numbers) */
	/*adiw R7:R6,5 (shame) */
	/* i guess we need to increment R7 5 times :| */ 
	inc R7
	inc R7
	inc R7
	inc R7 
	inc R7
	/* Check if we have reached the end of the loop */
	cp R7,R10
	brne adder_subroutine

  rjmp start
