;
; ADC_HUMIDITY.asm
;
; Created: 5/15/2017 5:10:46 PM
; Author : aligholamee
;
.include "m16_LCD_4bit.inc"
.def TEMP2 = R19
.def TEMP3 = R20

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
;======================INIT=============================================

;======================MAIN=============================================
start:
	; stay here until a conversion completes
	jmp start
;======================MAIN=============================================


;======================ADC_CC===========================================
ADC_CC:
	cli
	; ADC Conversion Complete ISR
	; Simply show the conversion result on the LCD
	in TEMP2,ADCL
	in TEMP3,ADCH
	mov argument,TEMP2
	call lcd_putchar
	mov argument,TEMP3
	call lcd_putchar
	ret
;======================ADC_CC===========================================
