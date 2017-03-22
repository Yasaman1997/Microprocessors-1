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
	ldi R16,0xFF	; Load 0b11111111 in R16
    out DDRB,R16	; Configure the PORT B as output 

	/* To reserve some place for the 7Segment encoding table in the memory
	* we need to use .db directive :)
	* The DB directive reserves memory resources in the program memory or the EEPROM memory.
	* In order to be able to refer to the reserved locations, the DB directive should be preceded by a label. 
	* The DB directive takes a list of expressions,
	* and must contain at least one expression. The DB directive must be placed in a Code Segment or an EEPROM Segment. */
	
   
    rjmp start		
