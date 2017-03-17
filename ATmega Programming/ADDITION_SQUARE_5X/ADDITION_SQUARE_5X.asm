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
	ldi R25,25
	mov R10,R25
	/* Find the square of the number */ 
	/* R7 will start this procedure from 0 and will be added 5 more each time */
	ldi R20,0
	/* Sqaure the R20 and put the result in R1:R0(mul does this by default) */
	mul R20,R20
	/* add the result to the R4:R3 (we need addition! not replacement :D) */
	add R3,R0
	adc R4,R1			
	/* We need to use R19 with R20 as a pair(since ADIW will put the result in a pair) */
	/*ldi R19,0 (shame) */
	/* Add immediate 5 to the word R20:R19 (because we need the sqaure of 5X numbers) */
	/*adiw R20:R19,5 (shame) */
	/* i guess we need to increment R20 5 times :| */ 
	inc R20
	inc R20
	inc R20
	inc R20 
	inc R20
	/* Check if we have reached the end of the loop */
	cp R20,R10
	brne adder_subroutine
	/* Final addition result is stored in R4:R3 */ 
	/* Put the result back to the R1:R0 */
	movw R1:R0,R4:R3
  rjmp start
