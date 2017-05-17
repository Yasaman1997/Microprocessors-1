;
; ADC_HUMIDITY.asm
;
; Created: 5/15/2017 5:10:46 PM
; Author : aligholamee
;
.include "m16_LCD_4bit.inc"
.def TEMP2 = R19
.def TEMP3 = R20
.def ADCLOW = R21
.def ADCHIGH = R22

;======================ADC_CC_INT=======================================
.org $001C
	jmp ADC_CC_INT
ADC_CC_INT:
	ret
;======================ADC_CC_INT=======================================


;======================INIT=============================================
initialize:
	; ADCSRA config
	ldi temp,(1 << ADEN)|(1 << ADPS2)|(1 << ADPS1)|(1 << ADPS0)|(1 << ADATE)|(1 << ADIE)
	out ADCSRA,temp

	; ADMUX config
	ldi temp,(0 << MUX4)|(0 << MUX3)|(0 << MUX2)|(0 << MUX1)|(1 << MUX0)|(0 << REFS1)|(1 << REFS0)
	out ADMUX,temp
;======================INIT=============================================


;======================MAIN=============================================
start:
	; stay here until a conversion completes
	jmp start
;======================MAIN=============================================


;======================ADC0 Conversion==================================
ADC0_CON:
	ldi TEMP2,0x00
    out ADMUX,TEMP2
	in TEMP2,ADCSRA
	ori TEMP2,(1<<ADSC)
	out ADCSRA,TEMP2
	in ADCLOW,ADCL
	in ADCHIGH,ADCH
	ret
;======================ADC0 Conversion==================================
