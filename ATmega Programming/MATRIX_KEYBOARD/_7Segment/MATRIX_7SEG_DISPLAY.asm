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
	; Pull-Up for PORT C on bits 4-7
	ldi r16, (0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
	out PORTC, r16
	; Find the column number
	sbic PINC,0
	jmp SET_COL_1
	sbic PINC,1
	jmp SET_COL_2
	sbic PINC,2
	jmp SET_COL_3
	sbic PINC,3
	jmp SET_COL_4
	ret

SET_COL_1:
	ldi col,1
	ldi dis_reg, 0x30
	jmp DISPLAY
	//jmp ROW_FIND
SET_COL_2:
	ldi col,2
		ldi dis_reg, 0x6D
	jmp DISPLAY
	//jmp ROW_FIND	
SET_COL_3:
	ldi col,3
		ldi dis_reg, 0x79
	jmp DISPLAY
//	jmp ROW_FIND	
SET_COL_4:
	ldi col,4
		ldi dis_reg, 0x33
	jmp DISPLAY
//	jmp ROW_FIND

/*
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
	add return_val,row */
	;==========TEST SECTION============
	; Simply convert and display
/*CND1:
	cpi return_val, 18
	breq DO_IT3 
	ret
	//jmp CND2

DO_IT3: 
	ldi dis_reg, 0x7E
	jmp DISPLAY


CND2:
	cpi return_val, 18
	breq DO_IT4 
	jmp CND3

DO_IT4: 
	ldi dis_reg, 0x30
	jmp DISPLAY

CND3:
	cpi return_val, 19
	breq DO_IT5 
	jmp CND5

DO_IT5: 
	ldi dis_reg, 0x6D
	jmp DISPLAY

CND5:
	cpi return_val, 20
	breq DO_IT6 
	jmp CND6

DO_IT6: 
	ldi dis_reg, 0x79
	jmp DISPLAY

CND6:
	cpi return_val, 33
	breq DO_IT7 
	jmp CND7

DO_IT7: 
	ldi dis_reg, 0x33
	jmp DISPLAY

CND7:
	cpi return_val, 34
	breq DO_IT8 
	jmp CND8

DO_IT8: 
	ldi dis_reg, 0x5B
	jmp DISPLAY

CND8:
	cpi return_val, 35
	breq DO_IT9 
	jmp CND9

DO_IT9: 
	ldi dis_reg, 0x5F
	jmp DISPLAY

CND9:
	cpi return_val, 49
	breq DO_IT10 
	jmp CND10

DO_IT10: 
	ldi dis_reg, 0x70
	jmp DISPLAY

CND10:
	cpi return_val, 50
	breq DO_IT11 
	jmp CND11

DO_IT11: 
	ldi dis_reg, 0x7F
	jmp DISPLAY

CND11:
	cpi return_val, 51
	breq DO_IT12 
	jmp CND13

DO_IT12: 
	ldi dis_reg, 0x7B
	jmp DISPLAY

CND13:
	cpi return_val, 52
	breq DO_IT13 
	jmp CND14

DO_IT13: 
	ldi dis_reg, 0x77
	jmp DISPLAY

CND14:
	cpi return_val, 65
	breq DO_IT14
	jmp CND15

DO_IT14: 
	ldi dis_reg, 0x1F
	jmp DISPLAY

CND15:
	cpi return_val, 66
	breq DO_IT15 
	jmp CND16

DO_IT15: 
	ldi dis_reg, 0x4E
	jmp DISPLAY

CND16:
	cpi return_val, 67
	breq DO_IT16 
	jmp CND17

DO_IT16: 
	ldi dis_reg, 0x3D
	jmp DISPLAY

CND17:
	cpi return_val, 68
	breq DO_IT17 

DO_IT17: 
	ldi dis_reg, 0x4F
	jmp DISPLAY
	*/
DISPLAY:
	out PORTB,dis_reg
	;====================================
	sei
	reti


.org $1C00
RESET_ISR:
	cli
	; Enable DDRC 
	ldi R16,(0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7) 
	out DDRC,R16

	; Enable the input direction for PD2
	ldi R16,(0 << PD2)
	out DDRD,R16

	; 

	ldi R16,0b11111111
	out DDRB,R16

	/*ldi R16,0x00
	out PORTB,R16*/

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
	rjmp start

