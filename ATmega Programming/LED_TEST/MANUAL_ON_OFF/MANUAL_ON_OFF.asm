;
; LED_TEST.asm
;
; Created: 4/1/2017 5:33:03 PM
; Author : Ali Gholami
;
; Program to test the LED ON/OFF states manually

; Replace with your application code
start:
    /* set the PINB0 data direction to 0 for input */
	/* This one simulates the key */
	cli
	ldi R16, (0 << PB2)	; Make PB2 as input
    out DDRB,R16	; Configure the PINB0 as input

	/* set the PORTB7 data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, (1 << PB7)	; Make PB7 as output 
	out DDRB,R17	; Configure the PORTB7 as output

OFF_MODE:
	/* Put the PORTB7 to 0 */ 
	ldi R18,0x00
	out PORTB,R18
	/* Check the content of PINB0 */
	ldi R19,0x01	; Load 0b00000001 in R19
	//cp PINB,R19		; Compare the contents to see if the button is pressed
	/* We cannot compare PIN or PORT registers with another Register from Regsiter file */
	/* Just copy the PINB to R20 and compare R20 and R19 */
	in R20,PINB
	cp R20,R19
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet
ON_MODE:
	/* Put the PORTB to 1 */
	ldi R18,(1 << PB7)
	out PORTB,R18
	/* Skip if bit bit 1 in PORT B is set */
	sbis $B,7
	brne ON_MODE	; Branch to the ON_MODE if the key isn't unpressed yet
rjmp start
