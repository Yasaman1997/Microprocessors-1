;
; LED_BLINKER.asm
;
; Created: 4/1/2017 6:53:17 PM
; Author : Ali Gholami
;
; Program to blink the LED 10 times with delay each time we press the button 

; Replace with your application code
start:
    /* set the PINB0 data direction to 0 for input */
	/* This one simulates the key */
	ldi R16, 0x01	; Load 0b00000001 in R16
    out DDRB,R16	; Configure the PINB0 as input

	/* set the PORTB data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, 0x80	; Load 0b10000000 in R17
	out DDRB,R17	; Configure the PORTB7 as output

OFF_MODE:
	/* Put the PORTB to 0 */ 
	ldi R18,0x00
	out PORTB,R18
	/* Check the content of PINB0 */
	/* Wait for the PINB to get pressed by the user */
	ldi R19,0x01	; Load 0b00000001 in R19
	cp PINB,R19		; Compare the contents to see if the button is pressed
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet

BLINK_MODE:
	/* Define a counter */
	ldi R20,0
	/* Turn on the LED */
	/* Put the PORTB to 1 */
	ldi R18,0xFF
	out PORTB,R18

	/* Create a delay */
	call LONG_DELAY

	/* Turn off the LED */
	ldi R18,0x00
	out PORTB,R18

	/* Increment the counter */

	/* Check the content of the counter */

	/* Delay function */
LONG_DELAY:
	ldi r25,0xFF
LOOP:
	nop
	dec R25
	cpi R25,0x00
	brne LOOP
ret

	
rjmp start
