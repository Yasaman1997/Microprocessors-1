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




