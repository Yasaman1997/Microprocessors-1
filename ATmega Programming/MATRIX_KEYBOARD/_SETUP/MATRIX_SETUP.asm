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

start:
    rjmp start
