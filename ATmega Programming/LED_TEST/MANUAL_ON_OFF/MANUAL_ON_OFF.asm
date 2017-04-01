;
; LED_TEST.asm
;
; Created: 4/1/2017 5:33:03 PM
; Author : Ali Gholami
;
; Program to test the LED ON/OFF states manually

; Replace with your application code
start:
    /* set the port b data direction to 0 for input */
	ldi R16, 0x0F	; Load 0b00000001 in R16
    out DDRB,R16	; Configure the PORTB0 as output
	rjmp start
