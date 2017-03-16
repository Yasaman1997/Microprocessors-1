;
; EEPROM_WRITE_ASM.asm
;
; Created: 3/16/2017 11:17:58 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
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
		
	
	
	
	
	
	/* Add 1 to the counter */
	add R16,1
	/* Check the loop end point */
	cp R16,R17
	brne EEPROM_WRITE
    rjmp EEPROM_WRITE
	rjmp start

