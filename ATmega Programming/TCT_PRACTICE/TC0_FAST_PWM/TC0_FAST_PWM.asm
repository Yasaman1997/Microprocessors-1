;
; TC0_FAST_PWM.asm
;
; Created: 5/8/2017 5:33:10 PM
; Author : aligholamee
;
;======================VECTORS==========================================
.def TEMP = R16

; RESET Vector
.org $000
	jmp RESET_ISR
;======================VECTORS==========================================


;======================TC0_COMPARE_MATCH_ISR=================================
TC0_ISR:
	cli
	; Simply increment the global counter for compare match
	sei
	ret
;======================TC0_COMPARE_MATCH_ISR=================================


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
	; Configure the TC0 Mode
	; Waveform Generation Mode Bits (WGM00 - WGM01)
	; These bits control the counting sequence of the counter, the source for the maximum (TOP)
	; counter value, and what type of Waveform Generation to be used
	; Configure the COM Bits
	ldi TEMP,(1 << CS02) | (0 << CS01) | (1 << CS00)| (1 << WGM00) | (0 << WGM01) | (0 << COM00) | (0 << COM01) 
	out TCCR0,TEMP

	; Set PB3 as output
	ldi TEMP,(1 << PB3)
	out DDRB,TEMP

	; Reset the prescaler in the SFIOR
	ldi TEMP,(1 << PSR10)
	out SFIOR,TEMP

	; Set the value of OCR0 = 0xFF 
	ldi TEMP,0xFF
	out OCR0,TEMP

	; Global Interrupt Enable
	sei
;======================RESET_ISR========================================


;======================MAIN=============================================
start:
	jmp start
;======================MAIN=============================================


;======================TOGGLE_LED=======================================
TOGGLE_LED:
	sbis PORTB,3
	jmp TURN_ON

TURN_OFF:
	ldi temp,(0 << PB3)
	out PORTB,temp
	ldi GLOBAL_COMPARE_MATCH_COUNTER,0
	ret
TURN_ON:
	ldi temp,(1 << PB3)
	out PORTB,temp
	ldi GLOBAL_COMPARE_MATCH_COUNTER,0
	; Get back to where you left ;)
	ret
;======================TOGGLE_LED=======================================