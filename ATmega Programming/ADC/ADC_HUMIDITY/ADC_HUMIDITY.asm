;
; ADC_HUMIDITY.asm
;
; Created: 5/15/2017 5:10:46 PM
; Author : aligholamee
;
;======================VECTORS==========================================
.def TEMP = R16

; RESET Vector
.org $000
	jmp RESET_ISR

; ADC Conversion Complete Interrupt Vector
.org $01C
	jmp ADC_CC
;======================VECTORS==========================================

;======================RESET_ISR========================================
RESET_ISR:
	
	; Stack Init
	ldi TEMP,HIGH(RAMEND)	
	out SPH,TEMP
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP
	
	; I'll enable the needed bits for the analog to digital convertor in
	; order to create an interrupt when the value goes between the MAX and MIN level
	; 1 - Choose the reference by setting the appropriate bits of REFSn in the ADMUX register
	ldi TEMP,(1 << REFS0)|(0 << REFS1)
	out ADMUX,TEMP




	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================
