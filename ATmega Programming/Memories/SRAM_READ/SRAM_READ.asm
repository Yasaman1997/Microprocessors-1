;
; SRAM_READ.asm
;
; Created: 5/30/2017 11:18:08 PM
; Author : aligholamee
;
; Reading from SRAM, The desired address is 1100H accroding to the question :D


;============== DEFS =================
.def TEMP = R16
;============== DEFS =================

;============ VECTORS ================
.org 0x00
	jmp RESET_ISR 
;============ VECTORS ================

;=========== RESET ISR ===============
RESET_ISR:
	; Setup the stack pointer
	ldi TEMP,HIGH(RAMEND)
	out SPH,TEMP
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP

	; put the port c and port d to output 
	ldi TEMP,0xFF
	out DDRC,TEMP
	out DDRD,TEMP

	; put the port a to input for reading purpose
	ldi TEMP,0x00
	out DDRA,TEMP
	
	ret
;=========== RESET ISR ===============

;========== MAIN PROGRAM =============
start:
	rjmp start
;========== MAIN PROGRAM =============