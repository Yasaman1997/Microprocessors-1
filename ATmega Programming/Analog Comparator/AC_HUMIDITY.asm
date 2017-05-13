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

	; Analog comparator control and status register (ACSR)
	; Make sure ACD - Analog Comparator Disable is cleared
	; Make sure ACBG - Analog Comparator Bandgap Select is cleared
	; Make sure no Interrupts are enabled(done by default)
	ldi TEMP,(0 << ACD)|(0 << ACBG)
	out ACSR,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================