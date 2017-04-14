;
; EDGE_LED_INTERRUPT.asm
;
; Created: 4/13/2017 6:07:36 AM
; Author : Ali Gholami
;
; A program to turn the LED on/off by pressing the SW1 button

; Reserved 2 bytes: jump to reset at the beginnning
	jmp RESET
; Configuration: Put the interrupt 1 vector at address $002
.org $002
CONF_INT_VEC:
	jmp EXT_INT1

; Main program start point
.org $1C00
RESET:
	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

	; Enable interrupts
	sei

	; Configuration: IVSEL = 0, BOOTRST = 0
CONF_INT:
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16

start:
	; Enable the input direction for PD3
	ldi R16,(0 << PD3)
	out DDRD,R16

	; Check for any interrupts from SW1 (Which is connected to PD3)
INT_CHECK:
	sbis PIND,3
	jmp INT_CHECK

	; Create a delay
	call SHORT_DELAY
	; In case we detected any interrupts, jump to CONF_INT_VEC, then EXT_INT1 
	jmp CONF_INT_VEC
    rjmp start

EXT_INT1:
	; Turn on the LED here, set PD7 as output for LED
	ldi R16,(1 << PD7)
	out DDRD,R16
		out DDRD,R16
	
	; Control the data output, Keep the LED on untill another key-press interrupt comes in
KEEP_ON:
	ldi R16,(1 << PD7)
	out PORTD,R16

	sbis PIND,3
	jmp KEEP_ON
	
	; Otherwise go to the KEEP_OFF
KEEP_OFF:
	ldi R16,(0 << PD7)
	out PORTD,R16

	sbis PIND,3
	jmp KEEP_OFF
	
	; Create a delay
	call SHORT_DELAY

	; Otherwise, go out of interrupt
	reti

	; A short delay for synchronization between press and reaction
SHORT_DELAY:
    ldi r25,10
LOOP:
    dec R25
    brne LOOP
    ret
