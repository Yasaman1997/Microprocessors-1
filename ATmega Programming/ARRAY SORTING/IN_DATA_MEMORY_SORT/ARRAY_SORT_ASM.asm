;
; ARRAY_SORT_2.asm
;
; Created: 4/6/2017 11:07:37 PM
; Author : Ali Gholami
;

		.equ  BLOCK1   =$60        ;start address of SRAM array #1
		.CSEG	; write to the program memory 
	ARRAY: .DB 1, 5, 4, 6, 2, 8, 7, 4, 9, 3	; The stored numbers in program memory
		.def flashsize = R16	; size for the elements block in the flash memory
	/* Setup the stack */
    ldi r16, 0
    out SPH, r16
    ldi r16, 0xf0
    out SPL, r16

	/* Z pointer configuration (source in flash) */
	ldi ZH,high(ARRAY << 1)
	ldi ZL,low(ARRAY << 1)
	/* Y pointer configuration (destination in sram) */
	ldi YH,high(BLOCK1)
	ldi YL,low(BLOCK1)

	ldi flashsize,10
	rcall flash2ram
	 
forever:
	rjmp forever

	/* Copy the data to the ram */
flash2ram:
	lpm 
	st Y+,R0
	adiw Zl,1
	dec flashsize
	brne flash2ram
	ret