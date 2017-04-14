;
; MATRIX_SETUP.asm
;
; Created: 4/14/2017 4:01:22 PM
; Author : Ali Gholami
;


; I'll setup a keyboard matrix in this file
; This code is written to identify the pressed number in the keyboard

; Reserved 2 bytes: jump to reset at the beginnning
.org 0x00
	jmp RESET_ISR


; Configuration: Put the interrupt 0 vector at address $002
.org 0x02
	jmp HANDLE_MATRIX_PRESS

HANDLE_MATRIX_PRESS:

KEY_FIND:
	; Find the column number
	; Pull-Up for PORT C on bits 4-7
	ldi r16, (0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
	out PORTC, r16


.org $1C00
RESET_ISR:
	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

	; Configure as any logical change in the interrupt sense control
	ldi R16,(0 << ISC01) | (1 << ISC00)
	out MCUCR,R16

	; Enable INT0
	ldi R16, (1 << INT0) 
	out GICR, R16

	; Configuration: IVSEL = 0, BOOTRST = 0
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16

	; Enable Global interrupt flag
	sei

	; Enable DDRC and set the whole port as input
	ldi R16,(0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (0 << PC4) | (0 << PC5) | (0 << PC6) | (0 << PC7) |
	out DDRC,R16

start:
	; Enable the input direction for PD2
	ldi R16,(0 << PD2)
	out DDRD,R16
	; Listen for interrupt!
	sbic PIND,2
	call HANDLE_MATRIX_PRESS
	rjmp start
