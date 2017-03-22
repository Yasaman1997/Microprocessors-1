;
; R_W_DISPLAY.asm
;
; Created: 3/22/2017 11:05:18 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
    /**************************/
	/* EEPROM WRITE */
		/* Define a counter in R16 */
	ldi R16,0
	ldi R17,8
	/* EEPROM Address to be written */
	ldi R18,0x00
	ldi R19,0x00
	/* Loop through this untill 9 numbers are written */
EEPROM_WRITE:
    /* Wait untill the EEWE gets 0 */
	/* Skip next instruction if EEWE is clear in EECR */
	sbic EECR,EEWE
	rjmp EEPROM_WRITE	
	/* Write the address to be filled with the number :D */
	out EEARL,R18
	out EEARH,R19	
	/* Write the data */
	/* Counter can be used itself */
	out EEDR,R16
	/* Write logical one to the EEMWE */
	/* Set bit immediate */
	sbi EECR,EEMWE
	/* Start write */
	sbi EECR,EEWE
	/* Add 1 to the counter */
	add R16,1
	/* Go to the next address on EEPROM */
	add R18,1
	/* Check the loop end point */
	cp R16,R17
	brne EEPROM_WRITE
    rjmp EEPROM_WRITE
	/**************************/


	/**************************/
	/* Configure port B and 7 SEG */
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
	.CSEG
	BCDTo7_Seg: .DB 0xCF, 0xA4, 0xB0, 0x00, 0x99, 0x92, 0x82, 0xF8, 0x80
	/**************************/

	/**************************/
	/* Read the data from EEPROM and Display on 7 Segment */
	/* Start the reading loop */
	/* a counter is defined already as R16 */
	/* Just reload R16 with 0 and R17 with 9 */ 
	ldi R16,0
	ldi R17,9
EEPROM_READ:
	/* Wait for completion of write procedure */
	sbic EECR,EEWE
	rjmp EEPROM_READ
	/* Set up the reading address */
	ldi R18,0
	ldi R19,0
	out EEARH,R19
	out EEARH,R18


	/* Check the loop end point */
	cp R16,R17
	brne EEPROM_READ
    rjmp start
