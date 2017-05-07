;
; TC0_CTC.asm
;
; Created: 5/7/2017 5:57:07 PM
; Author : aligholamee
;
; This program will use the TCT0 to blink the LEDs using CTC mode
.def temp = R16

; RESET Vector
.org 0x00
	jmp RESET_ISR

; RESET Routine
RESET_ISR:
	
	; Stack Init
	ldi temp,HIGH(RAMEND)	
	out SPH,temp
	ldi temp,LOW(RAMEND)
	out SPL,temp

	; Configure the clock source for TC0
	; The clock source is selected by the clock select logic which is controlled 
    ; by the clock select (CS02:0) bits located in the Timer/Counter Control Register (TCCR0)
	ldi temp,(1 << CS02) | (0 << CS01) | (1 << CS00)
	out TCNT0,temp

	; Set PD5 as output
	ldi temp << PD5)
	out DDRD,temp
	; Set PD4 as output 
	ldi temp,(1 << PD4)
	out DDRD,temp

	
	
start:
    rjmp start
