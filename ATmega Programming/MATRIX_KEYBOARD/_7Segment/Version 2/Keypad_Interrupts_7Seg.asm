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
	call FIND_COLUMN
	rjmp PASS_1

FIND_COLUMN:
	cpi R17,0b00000001
	breq COLUMN_1

	cpi R17,0b00000010
	breq COLUMN_2

	cpi R17,0b00000100
	breq COLUMN_3

	cpi R17,0b00001000
	breq COLUMN_4
	ret

	; find the row number as simple as possible
FIND_ROW:
	; labels for each column
	; First column check
COLUMN_1:
	cpi r18,0b00000001
	breq DISPLAY_0
	cpi r18,0b00000010
	breq DISPLAY_1
	cpi r18,0b00000100
	breq DISPLAY_2
	cpi r18,0b00001000
	breq DISPLAY_3
	ret

	; Second column check
COLUMN_2:
	cpi r18,0b00000001
	breq DISPLAY_4
	cpi r18,0b00000010
	breq DISPLAY_5
	cpi r18,0b00000100
	breq DISPLAY_6
	cpi r18,0b00001000
	breq DISPLAY_7
	ret

	; Third column check
COLUMN_3:
	cpi r18,0b00000001
	breq DISPLAY_8
	cpi r18,0b00000010
	breq DISPLAY_9
	cpi r18,0b00000100
	breq DISPLAY_10
	cpi r18,0b00001000
	breq DISPLAY_11
	ret

	; Fourth Column check
COLUMN_4:
	cpi r18,0b00000001
	breq DISPLAY_12
	cpi r18,0b00000010
	breq DISPLAY_13
	cpi r18,0b00000100
	breq DISPLAY_14
	cpi r18,0b00001000
	breq DISPLAY_15
	ret

DISPLAY_0:
	ldi r16,0x3f
	out PORTB,r16
	ret
DISPLAY_1:
	ldi r16,0x06
	out PORTB,r16
	ret
DISPLAY_2:
	ldi r16,0x5b
	out PORTB,r16
	ret
DISPLAY_3:
	ldi r16,0x4f
	out PORTB,r16
	ret
DISPLAY_4:
	ldi r16,0x66
	out PORTB,r16
	ret
DISPLAY_5:
	ldi r16,0x6d
	out PORTB,r16
	ret
DISPLAY_6:
	ldi r16,0x7d
	out PORTB,r16
	ret
DISPLAY_7:
	ldi r16,0x07
	out PORTB,r16
	ret
DISPLAY_8:
	ldi r16,0x7f
	out PORTB,r16
	ret
DISPLAY_9:
	ldi r16,0x6f
	out PORTB,r16
	ret
DISPLAY_10:
	ldi r16,0x5F
	out PORTB,r16
	ret
DISPLAY_11:
	ldi r16,0x7C
	out PORTB,r16
	ret
DISPLAY_12:
	ldi r16,0x58
	out PORTB,r16
	ret
DISPLAY_13:
	ldi r16,0x5E
	out PORTB,r16
	ret
DISPLAY_14:
	ldi r16,0xF9
	out PORTB,r16
	ret
DISPLAY_15:
	ldi r16,0x71
	out PORTB,r16
	ret

INT0_ISR:
	ldi R25,0x3F
	dec	R25
	call LOOP_MATRIX
	ret
LOOP_MATRIX:
	ldi R26,0x34
	dec R26
	brne LOOP_MATRIX
	ret

	
