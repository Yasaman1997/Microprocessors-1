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
.def IN_BUFF_DAT = R17
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
	; use polling method to find the device that has driven the interrupt
DEV1_POLL:
	sbis PINC,0
	rjmp DEV2_POLL
	; turn on the latch to show the result on the desired 7-segment
	ldi TEMP,0b00000000
	out PORTB,TEMP
DEV2_POLL:
	sbis PINC,1
	rjmp DEV3_POLL
	; turn on the latch to show the result on the desired 7-segment
	ldi TEMP,0b00000001
	out PORTB,TEMP
DEV3_POLL:
	sbis PINC,2
	rjmp DEV_FOUND
	; turn on the latch to show the result on the desired 7-segment
	ldi TEMP,0b00000010
	out PORTB,TEMP
	; turn on the 7 Segment according to the interrupt number
DEV_FOUND:
	; Get the data from buffers and store them somewhere :D
GET_DATA_FROM_BUFFER:
	nop 
	nop
	nop
	in IN_BUFF_DAT,PINA
	; Set the port A to output to send the data
SEND_DATA_TO_LATCH:
	ldi TEMP,0xFF
	out DDRA,TEMP

	; now get back to where u left :D
	ret
;=========== INT0 ISR =============


;=========== MAIN PROGRAM =========
start:
	; Set the port A to input and get the data
	ldi TEMP,0x00
	out DDRA,TEMP
	; To find the device that has made the interrupt
	; I'll connect the all ports of each device together in logical OR gate and connect the output of these 
	; 3 logical OR gates to the port C
	; So the PORT C will be used as input
	ldi TEMP,0x00
	out DDRC,TEMP
	; set the port b to output
	ldi TEMP,0b00000111
	out DDRB,TEMP
	; stay here untill an interrupt occurs
	rjmp start
;=========== MAIN PROGRAM =========
