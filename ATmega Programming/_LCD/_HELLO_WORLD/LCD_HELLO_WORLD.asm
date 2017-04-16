;
; LCD_HELLO_WORLD.asm
;
; Created: 4/16/2017 4:55:08 AM
; Author : Ali Gholami
;

; A program to write the "HELLO WORLD" string on the LCD
; The LCD connection will be done using some libraries
.include "m16_LCD_4bit.inc"

RESET_ISR:
	; Set the PD direction to output for LCD usage
	ldi R16,  (1 << PD4) | (1 << PD5) | (1 << PD6) | (1 << PD7)
	out DDRD, R16

	;


start:
    rjmp start
