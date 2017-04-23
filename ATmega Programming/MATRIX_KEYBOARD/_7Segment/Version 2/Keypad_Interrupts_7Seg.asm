;
; Keypad_Interrupts_7Seg.asm
;
; Created: 4/23/2017 9:08:32 PM
; Author : Ali Gholami
;
; This code will identify the pressed key in keypad using interrupts

.org 0x00
	jmp RESET	; Reset vector

.org 0x02
	jmp INT0_ISR	; INT0_ISR vector

RESET:
	; Stack init
	ldi R16,low(RAMEND)
	out SPL,R16
	ldi R16,high(RAMEND)
	out SPH,R16

	; DDRB output mode for 7 Segment 
	ldi R16,0xFF
	out DDRB,R16

	; DDRC - Half output - Half input
	ldi R16,0b11110000
	out DDRC,R16

	; PORTC - Input half pull-up
	ldi R16,0b00001111
	out PORTC,R16

	; MCUCR Config - toggle mode for interrupt_0 sense control
	ldi R16,(1 << ISC01) | (0 << ISC00)
	out MCUCR,R16

	; Enable INT0 in GICR
	ldi R16, (1 << INT0)
	out GICR, R16

	; Enable Global Interrupt Flag
	sei

	; Mode 1 is similar to what we have done in RESET
MODE_1:
	; DDRC - Half output - Half input
	ldi R16,0b11110000
	out DDRC,R16

	; PORTC - Input half pull-up
	ldi R16,0b00001111
	out PORTC,R16

	; Read PINC in the first pass
PASS_1:
	; Read PINC
	in R17,PINC

	; Mode 2 is actually the inverse of Mode 1
MODE_2:
	; DDRC - Half input - Half output
	ldi R16,0b00001111
	out DDRC,R16

	; PORTC - output half pull-up
	ldi R16,0b00001111
	out PORTC,R16
	
	; Read PINC in the second pass
PASS_2:
	; Read PINC
	in R18,PINC