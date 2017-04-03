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
	ldi R16, (0 << PB0)	; Load 0b00000001 in R16
    out DDRB,R16	; Configure the PINB0 as input

	/* set the PORTB7 data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, (1 << PB7)	; Load 0b10000000 in R17
	out DDRB,R17	; Configure the PORTB7 as output

OFF_MODE:
	/* Put the PORTB7 to 0 */ 
	ldi R18,(0 << PB7)
	out PORTB,R18
	/* Check the content of PINB0 */
	/* Wait for the PINB to get pressed by the user */
	sbis PINB,0
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet

BLINK_MODE:
	/* Define a counter */
	ldi R20,0
	/* Turn on the LED */
	/* Put the PORTB7 to 1 */
	ldi R18,(1 << PB7)
	out PORTB,R18

	/* Create a delay */
	call LONG_DELAY

	/* Turn off the LED */
	ldi R18,(0 << PB7)
	out PORTB,R18
	
	/* Increment the counter */
	inc R20
	
	/* Check the content of the counter */
	cpi R20,0x0A
	brne BLINK_MODE
	/* Clear the input to avoid duplicate press virtualization */
	cbi PINB,0
	jmp	OFF_MODE
rjmp start

	/* Delay function */
LONG_DELAY:
	ldi r25,10
LOOP:
	nop
	dec R25
	cpi R25,0
	brne LOOP
ret