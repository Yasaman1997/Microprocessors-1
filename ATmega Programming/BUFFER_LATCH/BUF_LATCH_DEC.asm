;
; BUF_LATCH_DEC.asm
;
; Created: 6/5/2017 11:00:40 AM
; Author : aligholamee
;
; A program to connect 3 interact between the input of the buffers and 7-segments that are connected to the latches
; On each 7-seg, we will show the number of pressed key according to the buffer that has got the interrupt

;============== DEFS ==============
.def TEMP = R16
;============== DEFS ==============

;============= VECTORS ============
.org 0x00
	rjmp RESET_ISR
.org 0x02
	rjmp ISR_0
;============= VECTORS ============

;============ RESET ISR ===========
RESET_ISR:
	; Setup the stack pointer
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP
	ldi TEMP,HIGH(RAMEND)
	out SPH,TEMP

	; configure interrupt 0
	; Configure the Rising Edge in the interrupt sense control
	ldi TEMP,(1 << ISC01) | (1 << ISC00)
	out MCUCR,TEMP

	; Enable INT0
	ldi TEMP, (1 << INT0) 
	out GICR, TEMP

	; Global interrupt enable
	sei


