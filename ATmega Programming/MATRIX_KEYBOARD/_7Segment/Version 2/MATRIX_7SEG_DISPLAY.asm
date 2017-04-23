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

	; set DDRD 0-3 as input
	ldi R16,(0 << PD0) | (0 << PD1) | (0 << PD2) | (0 << PD3)
	out DDRD,R16
	















start:
    rjmp start
