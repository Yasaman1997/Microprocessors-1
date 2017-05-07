;
; TC0_CTC.asm
;
; Created: 5/7/2017 5:57:07 PM
; Author : aligholamee
;
; This program will use the TCT0 to blink the LEDs using CTC mode

; RESET Vector
.org 0x00
	jmp RESET_ISR

start:
    rjmp start
