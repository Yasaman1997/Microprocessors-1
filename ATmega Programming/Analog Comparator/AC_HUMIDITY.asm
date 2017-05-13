;
; AC_HUMIDITY.asm
;
; Created: 5/13/2017 4:58:52 PM
; Author : aligholamee
;

;======================VECTORS==========================================
.def TEMP = R16

; RESET Vector
.org $000
	jmp RESET_ISR
;======================VECTORS==========================================
