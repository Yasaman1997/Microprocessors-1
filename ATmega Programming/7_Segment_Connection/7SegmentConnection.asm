;
; 7SegmentConnection.asm
;
; Created: 3/22/2017 8:59:55 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
	/* Connect the PORT B to the 7-Segment */
	/* This part must be done in the proteus simulator */

	/* Put the direction of port B to output */
	/* to do this we use DDR(Data Direction Register) and turn all ports to 1 */
	
	/* Put the numbers which are going to be written on DDRB in another register(like R16) */
	ldi R16,(1<<PB0)
    rjmp start
