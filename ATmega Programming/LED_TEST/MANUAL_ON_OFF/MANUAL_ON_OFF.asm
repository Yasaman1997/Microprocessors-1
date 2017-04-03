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
	cli
	/* set the PIND0 data direction to 0 for input */
	/* This one simulates the key */
	ldi R16, (0 << PD2)	; Make PD2 as input
    out DDRB,R16	; Configure the PIND0 as input
	ldi R16, (1 << PD2)	; PD2 Pull-Up
	out PORTD,R16

	/* Enable the Interrupt System */
	ldi R16, (1 << INT0)
	out GICR, R16


	/* set the PORTB7 data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, (1 << PB7)	; Make PB7 as output 
	out DDRB,R17	; Configure the PORTB7 as output
	sei

	
start:
OFF_MODE:
	/* Put the PORTB7 to 0 */ 
	ldi R18,(0 << PB7)
	out PORTB,R18
	/* Skip if PIN 0 in PORT D is set */
	sbis $12,0
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet
ON_MODE:
	/* Put the PORTB to 1 */
	ldi R18,(1 << PB7)
	out PORTB,R18
	/* Skip if PIN 0 in PORT D is set */
	sbis $12,7
	brne ON_MODE	; Branch to the ON_MODE if the key isn't unpressed yet
rjmp start
