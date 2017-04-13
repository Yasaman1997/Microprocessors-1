;
; EDGE_LED_INTERRUPT.asm
;
; Created: 4/13/2017 6:07:36 AM
; Author : Ali Gholami
;
; A program to turn the LED on/off by pressing the SW1 button

; Configuration: IVSEL = 0, BOOTRST = 0
CONF_INT:
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16

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
	

start:
	
    rjmp start
