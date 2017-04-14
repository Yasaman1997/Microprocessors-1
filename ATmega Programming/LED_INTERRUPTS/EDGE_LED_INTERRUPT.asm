;
; EDGE_LED_INTERRUPT.asm
;
; Created: 4/13/2017 6:07:36 AM
; Author : Ali Gholami
;
; A program to turn the LED on/off by pressing the SW1 button

; Reserved 2 bytes: jump to reset at the beginnning
.org 0x00
	jmp RESET_ISR

; Configuration: Put the interrupt 1 vector at address $002
.org 0x02
	jmp EXT_INT1

EXT_INT1:
	; Turn on the LED here, set PD7 as output for LED
	ldi R16,(1 << PD7)
	out DDRD,R16
	out PORTD,R16
	
	; Control the data output, Keep the LED on untill another key-press interrupt comes in
KEEP_ON:
	sbis PIND,3
	jmp KEEP_ON
	
	; Create a delay
	call SHORT_DELAY

	; Otherwise go to the KEEP_OFF
	ldi R16,(0 << PD7)
	out PORTD,R16

KEEP_OFF:
	sbis PIND,3
	jmp KEEP_OFF
	
	; Create a delay
	call SHORT_DELAY

	; Enable Global interrupt flag
	sei
	ret

RESET_ISR:
	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

	; Enable INT1
	ldi r16, (1 << INT1) 
	out GICR, r16

	; Configuration: IVSEL = 0, BOOTRST = 0
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16

	; Enable Global interrupt flag
	sei

start:
	; Enable the input direction for PD3
	ldi R16,(0 << PD3)
	out DDRD,R16
    rjmp start

	; A short delay for synchronization between press and reaction
SHORT_DELAY:
    ldi r25,5
LOOP:
    dec R25
    brne LOOP
    ret
