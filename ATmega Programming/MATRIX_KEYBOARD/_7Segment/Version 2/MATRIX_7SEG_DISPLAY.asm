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

	; Set DDRD 0-3 as input and 4-7 output
	ldi R16,(0 << PD0) | (0 << PD1) | (0 << PD2) | (0 << PD3) | (1 << PD4) | (1 << PD5) | (1 << PD6) | (1 << PD7)
	out DDRD,R16
	
	; Put the higher PORTs as pull-up
	ldi R16,(1 << PB4) | (1 << PD5) | (1 << PD6) | (1 << PD7)
	out PORTD,R16

	; Set the interrupt0 bit
	ldi R16, (1 << INT0)
	out GICR, R16

	; Configure the interrupt sense control	
	ldi R16,(0 << ISC11) | (1 << ISC10)
	out MCUCR,r16

	; Set the global interrupt flag
	sei



start:
    rjmp start
