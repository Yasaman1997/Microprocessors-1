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
		.def temp1 = R25
		.def bubble = R26
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
	ldi bubble,0

	rcall flash2ram

	/* X pointer configuration (destination in sram) */
	ldi XH,high(BLOCK1)
	ldi XL,low(BLOCK1)

	/* Sorting logic */
	/* define counters for inner and outer loops */
	ldi R20,10
OUTER_LOOP:
	ldi R21,10
	mov XL,bubble
INNER_LOOP:
	/* Load numbers into registers using Y pointer */
	ld R22,X+
	ld R23,X
	
	/* compare two numbers */
	cp R22,R23
	brlt SWAP_ROUTINE
HERE:
	dec R21
	brne INNER_LOOP

	dec R20
	inc bubble
	brne OUTER_LOOP

	 
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

SWAP_ROUTINE:
	/* Change the content of R22 and R23 addresses */
	/* We have the address of R23 atm in Y */
	/* We have the address of R22 in the -Y pointer */
	/* We need to swap the contents of R22 and R23 */
	/* Swap */
	st X,R22	; Store the contents of R22 in R23's pointer place in SRAM
	st -X,R23	; Store the contents of R23 in R22's pointer place in SRAM
	inc XL
	jmp HERE



