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
	; Configure the any logical change :D in the interrupt sense control
	ldi TEMP,(0 << ISC01) | (1 << ISC00)
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
	; Get the data from buffers and store them somewhere :D
GET_DATA_FROM_BUFFER:
	nop 
	nop
	nop
	in IN_BUFF_DAT,PINA
	; find which device has made the interrupt
	; use polling method to find the device that has driven the interrupt
DEV1_POLL:
	sbis PINC,0
	rjmp DEV2_POLL
	; turn on the latch to show the result on the FIRST 7-segment
	ldi TEMP,0b00000000
	out PORTB,TEMP

DEV2_POLL:
	sbis PINC,1
	rjmp DEV3_POLL
	; turn on the latch to show the result on the SECOND 7-segment
	ldi TEMP,0b00000001
	out PORTB,TEMP
DEV3_POLL:
	sbis PINC,2
	rjmp DEV_FOUND
	; turn on the latch to show the result on the THIRD 7-segment
	ldi TEMP,0b00000010
	out PORTB,TEMP
	; turn on the 7 Segment according to the interrupt number
DEV_FOUND:
	; Set the port A to output to send the data
SEND_DATA_TO_LATCH:
	ldi TEMP,0xFF
	out DDRA,TEMP
	; Check which line has made Hi-Z :)
	call LINE_CHECK
	out PINA,IN_BUFF_DAT
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
	; Enable all buffers
	ldi TEMP,0b00000011
	out PORTB,TEMP	
	; stay here untill an interrupt occurs
	rjmp start
;=========== MAIN PROGRAM =========

;======= 7 Segment Display ========
DISPLAY_0:

DISPLAY_1:

DISPLAY_2:

DISPLAY_3:

DISPLAY_4:

DISPLAY_5:

DISPLAY_6:

DISPLAY_7:

DISPLAY_8:

DISPLAY_9:
;======= 7 Segment Display ========


;========== LINE CHECK ============
LINE_CHECK:
	
LINE_0:
	sbic PINA,0
	rjmp LINE_2
	call DISPLAY_0
	ret
LINE_1:
	sbic PINA,1
	rjmp LINE_2
	call DISPLAY_1
	ret
LINE_2:
	sbic PINA,2
	rjmp LINE_3
	call DISPLAY_2
	ret
LINE_3:
	sbic PINA,3
	rjmp LINE_4
	call DISPLAY_3
	ret
LINE_4:
	sbic PINA,4
	rjmp LINE_5
	call DISPLAY_4
	ret
LINE_5:
	sbic PINA,5
	rjmp LINE_6
	call DISPLAY_5
	ret
LINE_6:
	sbic PINA,6
	rjmp LINE_7
	call DISPLAY_6
	ret
LINE_7:
	sbic PINA,7
	ret
	call DISPLAY_7
	ret
;========== LINE CHECK ============

