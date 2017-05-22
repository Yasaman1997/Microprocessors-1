;
; USART_ASM.asm
;
; Created: 5/21/2017 9:32:59 PM
; Author : aligholamee
;
; Program to connect the atmega16 with the virtual DB9 port through MAX232

.def TEMP = R16
.def F_OSC = R17
.def 
;======================VECTORS==========================================
.org 0x00
	jmp RESET_ISR


;======================VECTORS==========================================

;======================RESET_ISR========================================
RESET_ISR:
	; Configure the clock generation mode
	; Configure the USART polarity mode 
	; The even parity will be used
	; Configure the stop bits
	; Configure the data bits = 8 bits for data
	ldi TEMP,(1 << UPM0)|(1 << UPM0)|(0 << UMSEL)|(1 << USBS)|(1 << UCSZ0)|(1 << UCSZ1)
	out UCSRC,TEMP
	; Enable USART send and recieve
	ldi TEMP,(0 << UCSZ2)|(1 << RXEN)|(1 << TXEN)
	out UCSRB,TEMP

;======================RESET_ISR========================================



;======================MAIN PROGRAM=====================================
start:
	rjmp start

;======================MAIN PROGRAM=====================================

