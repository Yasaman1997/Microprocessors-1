;
; HELLO_WORLD_MEM.asm
;
; Created: 4/16/2017 9:59:41 PM
; Author : Ali Gholami
;
; A program to show the grabbed data from an specific array in the flash and show them on the LCD
.include "m16_LCD_4bit.inc"
; Write an array of data in the flash section(code section)
.CSEG
LCDTABLE: .DB 14, 'M', 'Y', 'N', 'A', 'M', 'E', 'I', 'S', 'M', 'E', 'T', 'H', 'O', 'S'


start:
    rjmp start

; This routine will make the microcontroller to show the stored data in the address LCDTABLE
LCD:
	ldi ZH, high(LCDTABLE << 1)
	ldi ZL, low(LCDTABLE << 1)
	lpm argument, Z+
	rcall lcd_putchar
	