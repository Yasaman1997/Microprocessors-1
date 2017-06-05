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
	rjmp start
;============ RESET ISR ===========

;=========== INT0 ISR =============
ISR_0:
	; find which device has made the interrupt

	; turn on the 7 Segment according to the interrupt number

	; now get back to where u left :D
;=========== INT0 ISR =============


;=========== MAIN PROGRAM =========
start:
	; Set the port A to input and get the data
	ldi TEMP,0x00
	out PORTA,TEMP
	; To find the device that has made the interrupt
	; I'll connect the all ports of each device together in logical OR gate and connect the output of these 
	; 3 logical OR gates to the port C
	; So the PORT C will be used as input
	ldi TEMP,0x00
	out PORTC,TEMP
	; stay here untill an interrupt occurs
	rjmp start
;=========== MAIN PROGRAM =========
