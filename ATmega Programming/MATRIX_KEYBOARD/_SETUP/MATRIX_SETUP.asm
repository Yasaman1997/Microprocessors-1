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

start:
    rjmp start
