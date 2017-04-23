;
; KEYPAD_7SEGMENT_VER2.asm
;
; Created: 4/23/2017 9:56:49 AM
; Author : Ali Gholami
; This application will enable the interrupts of atmega by pressing each keypad button
.def COL_NUMBER = R20
.def ROW_NUMBER = R21

.org 0x00
jmp RESET

; Interrupt Service Routine Vector Declaration
.org 0x02
jmp INT0_ISR

RESET:
	; Init the stack pointer
	ldi R16,low(RAMEND)
	out SPL,R16
	ldi R16,high(RAMEND)
	out SPH,R16

	; Set DDRD 0-7 as input
	ldi R16,(1 << PC0) | (1 << PC1) | (1 << PC2) | (1 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
	out DDRC,R16
	
	; Put the higher PORTs as pull-up
	ldi R16,(1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
	out PORTC,R16

	; Set the interrupt0 bit
	ldi R16, (1 << INT0)
	out GICR, R16

	; Configure the interrupt sense control	
	ldi R16,(0 << ISC11) | (1 << ISC10)
	out MCUCR,r16

	; Set the global interrupt flag
	sei

	; This section will find the ROW number quickly ;)
	; Stay in this section until a key is pressed
	; When an  interrupts comes in from the INT0 pin, The COL_RECOGNIZER will be routed through the INT0_ISR
COL_RECOGNIZER:
	; Make COL 1 zero
	ldi R16,(0 << PC4)
	ldi COL_NUMBER,1
	call delay
	
	; Make COL 2 Zero
	ldi R16,(0 << PC5)
	ldi COL_NUMBER,2
	call delay 
	
	; Make COL 3 Zero
	ldi R16,(0 << PC6)
	ldi COL_NUMBER,3
	call delay

	; Make COL 4 Zero
	ldi R16,(0 << PC7)
	ldi COL_NUMBER,4
	call delay
	
	; No interrupts :D 
	; Go back to COL_RECOGNIZER
	jmp COL_RECOGNIZER

INT0_ISR:
	