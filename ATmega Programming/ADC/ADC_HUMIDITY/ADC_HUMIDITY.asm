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
