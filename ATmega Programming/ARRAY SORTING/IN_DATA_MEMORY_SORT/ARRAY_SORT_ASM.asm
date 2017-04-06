;
; ARRAY_SORT_2.asm
;
; Created: 4/6/2017 11:07:37 PM
; Author : Ali Gholami
;

		.CSEG	; write to the program memory 
	ARRAY: .DB 1, 5, 4, 6, 2, 8, 7, 4, 9, 3	; The stored numbers in program memory
		.def flashsize = R16	; size for the elements block in the flash memory
start:

    rjmp start

flash2ram:
	lpm 
	st Y+,R0
	adiw Zl,1
	dec flashsize
	brne flash2ram
	ret