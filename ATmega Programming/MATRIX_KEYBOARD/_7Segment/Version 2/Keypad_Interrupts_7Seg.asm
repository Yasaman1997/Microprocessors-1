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
