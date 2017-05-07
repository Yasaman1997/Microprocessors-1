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

	; Configure the TC0 Mode
	; Waveform Generation Mode Bits (WGM00 - WGM01)
	; These bits control the counting sequence of the counter, the source for the maximum (TOP)
	; counter value, and what type of Waveform Generation to be used
	ldi temp,(0 << WGM00) | (0 << WGM01)
	out TCCR0,temp

	; Configure the COM Bits
	; Since there are no compare matches going to happen in this program, 
	; we will make sure they are 0 :)
	/* MAKE SURE YOU DON'T OVERRIDE THE PREVIOUS TEMP VALUE */
	ori temp,(0 << COM00) | (0 << COM01)
	out TCCR0,temp

	; Set PD5 as output
	ldi temp << PD5)
	out DDRD,temp
	; Set PD4 as output 
	ldi temp,(1 << PD4)
	out DDRD,temp
start:
    rjmp start
