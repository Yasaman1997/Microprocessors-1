;
; MATRIX_7SEG_DISPLAY.asm
;
; Created: 4/15/2017 12:45:18 PM
; Author : Ali Gholami
;
; This code is written to identify and show the pressed number in the keyboard
.def col = R20
.def row = R21
.def return_val = R24
.def dis_reg = R18

; Reserved 2 bytes: jump to reset at the beginnning
.org 0x00
	jmp RESET_ISR


; Configuration: Put the interrupt 0 vector at address $002
.org 0x02
	jmp HANDLE_MATRIX_PRESS

HANDLE_MATRIX_PRESS:

KEY_FIND:

COL_FIND:
	; Pull-Up for PORT C on bits 0-3
	ldi r16, (1 << PC0) | (1 << PC1) | (1 << PC2) | (1 << PC3) | (0 << PC4) | (0 << PC5) | (0 << PC6) | (0 << PC7)
	out PORTC, r16

	; Find the column number
	sbis PINC,0
	jmp SET_COL_1
	sbis PINC,1
	jmp SET_COL_2
	sbis PINC,2
	jmp SET_COL_3
	sbis PINC,3
	jmp SET_COL_4

SET_COL_1:
	ldi col,1
	jmp ROW_FIND
SET_COL_2:
	ldi col,2
	jmp ROW_FIND	
SET_COL_3:
	ldi col,3
	jmp ROW_FIND	
SET_COL_4:
	ldi col,4
	jmp ROW_FIND


ROW_FIND:
	; Pull-Up for PORT C on bits 4-7
	ldi r16, (0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
	out PORTC, r16

	; Find the row number
	sbis PINC,0
	jmp SET_ROW_1
	sbis PINC,1
	jmp SET_ROW_2
	sbis PINC,2
	jmp SET_ROW_3
	sbis PINC,3
	jmp SET_ROW_4

SET_ROW_1:
	ldi row,1
	jmp CALCULATE_AND_RETURN
SET_ROW_2:
	ldi row,2
	jmp CALCULATE_AND_RETURN	
SET_ROW_3:
	ldi row,3
	jmp CALCULATE_AND_RETURN	
SET_ROW_4:
	ldi row,4
	jmp CALCULATE_AND_RETURN

CALCULATE_AND_RETURN:
	mov return_val,col
	lsl return_val
	lsl return_val
	lsl return_val
	lsl return_val
	add return_val,row
	ret


.org $1C00
RESET_ISR:

	; Enable DDRC 
	ldi R16,(0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7) 
	out DDRC,R16

	; Enable the input direction for PD2
	ldi R16,(0 << PD2)
	out DDRD,R16

	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

	; Configure as any logical change in the interrupt sense control
	ldi R16,(0 << ISC01) | (0 << ISC00)
	out MCUCR,R16

	; Enable INT0
	ldi R16, (1 << INT0) 
	out GICR, R16

	/*; Configuration: IVSEL = 0, BOOTRST = 0
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16*/

	; Enable Global interrupt flag
	sei

start:
	; When we get back from the interrupt routine
	; Simply convert and display
	cpi return_val, 17
	ldi dis_reg, 0x7E
	jmp DISPLAY

	cpi return_val, 18
	ldi dis_reg, 0x30
	jmp DISPLAY

	cpi return_val, 19
	ldi dis_reg, 0x6D
	jmp DISPLAY

	cpi return_val, 20
	ldi dis_reg, 0x79
	jmp DISPLAY

	cpi return_val, 33
	ldi dis_reg, 0x33
	jmp DISPLAY

	cpi return_val, 34
	ldi dis_reg, 0x5B
	jmp DISPLAY

	cpi return_val, 35
	ldi dis_reg, 0x5F
	jmp DISPLAY

	cpi return_val, 49
	ldi dis_reg, 0x70
	jmp DISPLAY

	cpi return_val, 50
	ldi dis_reg, 0x7F
	jmp DISPLAY

	cpi return_val, 51
	ldi dis_reg, 0x7B
	jmp DISPLAY

	cpi return_val, 52
	ldi dis_reg, 0x77
	jmp DISPLAY

	cpi return_val, 65
	ldi dis_reg, 0x1F
	jmp DISPLAY

	cpi return_val, 66
	ldi dis_reg, 0x4E
	jmp DISPLAY

	cpi return_val, 67
	ldi dis_reg, 0x3D
	jmp DISPLAY

	cpi return_val, 68
	ldi dis_reg, 0x4F
	jmp DISPLAY

DISPLAY:
	out PORTB,dis_reg
STAY_HERE:
	jmp STAY_HERE
	rjmp start

