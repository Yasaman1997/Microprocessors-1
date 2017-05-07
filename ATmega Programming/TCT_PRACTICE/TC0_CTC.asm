;
; TC0_CTC.asm
;
; Created: 5/7/2017 5:57:07 PM
; Author : aligholamee
;
; This program will use the TCT0 to blink the LEDs using CTC mode

;======================VECTORS==========================================
.def TEMP = R16
.def GLOBAL_OVERFLOW_COUNTER = R17

; RESET Vector
.org $000
	jmp RESET_ISR

; TC0 Overflow Vector
.org $012
	jmp TC0_ISR
;======================VECTORS==========================================


;======================RESET_ISR========================================
RESET_ISR:
	
	; Stack Init
	ldi TEMP,HIGH(RAMEND)	
	out SPH,TEMP
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP

	; Configure the clock source for TC0
	; The clock source is selected by the clock select logic which is controlled 
    ; by the clock select (CS02:0) bits located in the Timer/Counter Control Register (TCCR0)
	ldi TEMP,(1 << CS02) | (0 << CS01) | (1 << CS00)
	out TCNT0,TEMP

	; Configure the TC0 Mode
	; Waveform Generation Mode Bits (WGM00 - WGM01)
	; These bits control the counting sequence of the counter, the source for the maximum (TOP)
	; counter value, and what type of Waveform Generation to be used
	ldi TEMP,(0 << WGM00) | (0 << WGM01)
	out TCCR0,TEMP

	; Configure the COM Bits
	; Since there are no compare matches going to happen in this program, 
	; we will make sure they are 0 :)
	/* MAKE SURE YOU DON'T OVERRIDE THE PREVIOUS TEMP VALUE */
	ori TEMP,(0 << COM00) | (0 << COM01)
	out TCCR0,TEMP

	; Set PD5 as output
	ldi TEMP (1 << PD5)
	out DDRD,TEMP
	; Set PD4 as output 
	ldi TEMP,(1 << PD4)
	out DDRD,TEMP

	; Enable TC0 Overflow Interrupt (TOIE0)
	; When the TOIE0 bit is written to one, and the I-bit in the Status Register is set (one), the
	; Timer/Counter0 Overflow interrupt is enabled. 
	ldi TEMP,(1 << TOIE0)
	out TIMSK,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================


;======================MAIN=============================================
start:
    rjmp start
;======================MAIN=============================================


;======================TC0_OVERFLOW_ISR=================================
TC0_ISR:
	; Simply increment the global counter for overflow
	inc GLOBAL_OVERFLOW_COUNTER
	ret
;======================TC0_OVERFLOW_ISR=================================