;
; KEYPAD_7SEGMENT_VER2.asm
;
; Created: 4/23/2017 9:56:49 AM
; Author : Ali Gholami
; This application will enable the interrupts of atmega by pressing each keypad button
jmp RESET


RESET:
	; Init the stack pointer
	ldi R16,low(RAMEND)
	out SPL,R16
	ldi R16,high(RAMEND)
	out SPH,R16

	; Set DDRD 0-3 as input
	ldi R16,(0 << PD0) | (0 << PD1) | (0 << PD2) | (0 << PD3) | (0 << PD4) | (0 << PD5) | (0 << PD6) | (0 << PD7)
	out DDRD,R16
	
	; Put the higher PORTs as pull-up
	ldi R16,(1 << PB4) | (1 << PD5) | (1 << PD6) | (1 << PD7)
	out PORTD,R16












start:
    rjmp start
