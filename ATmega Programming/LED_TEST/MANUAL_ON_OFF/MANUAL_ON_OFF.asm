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
	ldi R16, 0x01	; Load 0b00000001 in R16
    out DDRB,R16	; Configure the PINB0 as output
	/* set the PORTB data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, 0x80	; Load 0b10000000 in R17
	out DDRB,R17
OFF_MODE:
	/* Put the PORTB
	/* Check the content of PORTB0 */
	ldi R17,0x01	; Load 0b00000001 in R16
	cp PINB,R17		; Compare the contents to see if the button is pressed
	brne OFF_MODE	; Branch to the OFF_MODE if the key isn't pressed yet

	rjmp start
