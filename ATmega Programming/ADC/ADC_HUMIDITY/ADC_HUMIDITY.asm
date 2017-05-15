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

	; 2 - Choose whether the analog input channel and the differential gain by setting the MUX bits in the regsiter ADMUX
	; Since the question is asking for an alarm in case the humidity of the environment is out of the domain,
	; In this section, we only use the single channel mode for the ADC1 and convert the analog input to a digital output
	in ADMUX,TEMP
	ori TEMP,(0 <<  MUX4)|(0 << MUX3)|(0 << MUX2)|(0 << MUX1)|(1 << MUX0)
	out ADMUX

	; 3 - The ADC is enabled by setting the ADC Enable bit, ADEN in ADCSRA. Voltage reference and
	; input channel selections will not go into effect until ADEN is set
	; Turn the ADC Interrupt on
	; Keep the prescaler values same as the default
	ldi TEMP,(1 << ADEN)|(1 << ADIE)
	out ADCSRA,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================
