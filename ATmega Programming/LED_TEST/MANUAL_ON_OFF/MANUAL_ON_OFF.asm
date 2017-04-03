;
; LED_TEST.asm
;
; Created: 4/1/2017 5:33:03 PM
; Author : Ali Gholami
;
; Program to test the LED ON/OFF states manually

.org 0x00
	jmp ISR_HERE

ISR_HERE:
	
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
	ldi R18,(0 << PB7)
	out PORTB,R18
	/* Skip if PIN 1 in PORT B is set */
	sbis $B,0
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet
ON_MODE:
	/* Put the PORTB to 1 */
	ldi R18,(1 << PB7)
	out PORTB,R18
	/* Skip if PIN bit 1 in PORT B is set */
	sbis $B,7
	brne ON_MODE	; Branch to the ON_MODE if the key isn't unpressed yet
rjmp start
