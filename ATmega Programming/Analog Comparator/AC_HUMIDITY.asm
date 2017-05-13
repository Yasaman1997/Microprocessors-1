;
; AC_HUMIDITY.asm
;
; Created: 5/13/2017 4:58:52 PM
; Author : aligholamee
;

;======================VECTORS==========================================
.def TEMP = R16

; RESET Vector
.org $000
	jmp RESET_ISR
;======================VECTORS==========================================

;======================RESET_ISR========================================
RESET_ISR:
	
	; Stack Init
	ldi TEMP,HIGH(RAMEND)	
	out SPH,TEMP
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================