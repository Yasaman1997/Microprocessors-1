;
; MATRIX_7SEG_DISPLAY.asm
;
; Created: 4/15/2017 12:45:18 PM
; Author : Ali Gholami
;


; A program to find the number of each button press in the matrix keyboard and display the numbers on the 7 Segment
; Simply store the codes needed for the 7 Segment in the EEPROM memory 

;====================0=====1=====2=====3=====4=====5=====6=====7=====8=====9====
.ESEG
ENCODE_NUMBERS: .DB 0xC0, 0xFC, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90 


; The first part of the code is the matrix setup from the previous section
; This code is written to identify the pressed number in the keyboard
.def col = R20
.def row = R21
.def return_val = R1
.def SH_RS = R19
.def E2_OFFSET = R22

; Reserved 2 bytes: jump to reset at the beginnning
.org 0x00
	jmp RESET_ISR


; Configuration: Put the interrupt 0 vector at address $002
.org 0x02
	jmp HANDLE_MATRIX_PRESS

HANDLE_MATRIX_PRESS:

KEY_FIND:

COL_FIND:
	; Enable DDRC for LSBs of PC
	ldi R16,(1 << PC0) | (1 << PC1) | (1 << PC2) | (1 << PC3) | (0 << PC4) | (0 << PC5) | (0 << PC6) | (0 << PC7) |
	out DDRC,R16

	; Pull-Up for PORT C on bits 4-7
	ldi r16, (0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7)
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
	; Enable DDRC for MSBs of PC
	ldi R16,(0 << PC0) | (0 << PC1) | (0 << PC2) | (0 << PC3) | (1 << PC4) | (1 << PC5) | (1 << PC6) | (1 << PC7) |
	out DDRC,R16

	; Pull-Up for PORT C on bits 0-3
	ldi r16, (1 << PC0) | (1 << PC1) | (1 << PC2) | (1 << PC3) | (0 << PC4) | (0 << PC5) | (0 << PC6) | (0 << PC7)
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
	; Set E2_OFFSET = 0
	ldi E2_OFFSET,0
	
	; Set stack pointer to the top of ram 
	ldi R16,high(RAMEND)
	out SPH,R16
	ldi R16,low(RAMEND)
	out SPL,R16

	; Configure as any logical change in the interrupt sense control
	ldi R16,(0 << ISC01) | (1 << ISC00)
	out MCUCR,R16

	; Enable INT0
	ldi R16, (1 << INT0) 
	out GICR, R16

	; Configuration: IVSEL = 0, BOOTRST = 0
	; Make sure that the IVSEL is set to 0
	ldi R16,(0 << IVCE)
	out GICR,R16
	ldi R16,(0 << IVSEL)
	out GICR,R16

	; Enable Global interrupt flag
	sei

start:
	; Enable the input direction for PD2
	ldi R16,(0 << PD2)
	out DDRD,R16
	; Listen for interrupt!
	sbic PIND,2
	call HANDLE_MATRIX_PRESS


	; Ok :D When returned, we have the desired number in the R1
	; Lets start showing it on the 7 Segment 
	; Convert the number into the normal mode
	; Put the converted number in the SH_RS variable
	mov SH_RS, return_value
	; Compare the returned value with the immediate
	cpi SH_RS, 17

	rjmp start

