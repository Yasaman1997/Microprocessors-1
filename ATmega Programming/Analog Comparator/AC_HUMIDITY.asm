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
	; Make sure ACIE - Analog Comparator Interrupt Enable is enabled
	; The interrupt mode has been set on the toggle mode
	ldi TEMP,(0 << ACD)|(0 << ACBG)|(1 << ACIE)|(0 << ACIS1)|(0 << ACIS0)
	out ACSR,TEMP

	; LED1 - PD5 OUTPUT
	ldi TEMP,(1 << PD5)
	out DDRD,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================