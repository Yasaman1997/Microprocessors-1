;
; USART_ASM.asm
;
; Created: 5/21/2017 9:32:59 PM
; Author : aligholamee
;
; Program to connect the atmega16 with the virtual DB9 port through MAX232

.def TEMP = R16
;======================VECTORS==========================================
.org 0x00
	jmp RESET_ISR


;======================VECTORS==========================================

;======================RESET_ISR========================================
RESET_ISR:
	; Configure the clock generation mode
	; configure the USART polarity mode 
	; The even parity will be used
	ldi TEMP,(1 << UPM0)|(1 << UPM0)|(0 << UMSEL)
	out UCSRC


;======================RESET_ISR========================================


