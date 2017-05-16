;
; ADC_HUMIDITY.asm
;
; Created: 5/15/2017 5:10:46 PM
; Author : aligholamee
;
.include "m16_LCD_4bit.inc"
;======================RESET_ISR========================================
RESET_ISR:
	

;======================RESET_ISR========================================

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
	in TEMP,ADCL
	mov argument,TEMP
	call lcd_putchar
	in TEMP,ADCH
	mov argument,TEMP
	call lcd_putchar
	ret
;======================ADC_CC===========================================
