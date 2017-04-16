;
; HELLO_WORLD_MEM.asm
;
; Created: 4/16/2017 9:59:41 PM
; Author : Ali Gholami
;


; A program to show the grabbed data from an specific array in the flash and show them on the LCD

; Write an array of data in the flash section(code section)
.CSEG
LCDTABLE: .DB 14, 'M', 'Y', 'N', 'A', 'M', 'E', 'I', 'S', 'M', 'E', 'T', 'H', 'O', 'S'

.org 0x00
	RESET_ISR

RESET_ISR:
	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

start:
   
    rjmp start
