;
; USART_ASM.asm
;
; Created: 5/21/2017 9:32:59 PM
; Author : aligholamee
;
; Program to connect the atmega16 with the virtual DB9 port through MAX232
.include "m16_LCD_4bit.inc"
.def ROW = R21
.def COL = R25
.def BAUD_LOW = R19
.def BAUD_HIGH = R24
.def TEMP2 = R20
.def DATA_TO_BE_SENT = R22
.def RECIEVE_STATUS = R23
;======================VECTORS==========================================

;======================VECTORS==========================================

;======================MAIN PROGRAM=====================================
start:
;======================USART_INIT=======================================
	; Load row and col with 0 for compare purpose
	ldi COL,0
	ldi ROW,5

	; Set the baud rate to 4800 bps
	ldi BAUD_LOW,12
	ldi BAUD_HIGH,0
	; Configure the baud rate
	out UBRRH,BAUD_HIGH
	out UBRRL,BAUD_LOW

	; Enable USART send and recieve + Their interrupts
	ldi TEMP,(1 << UCSZ2)|(1 << RXEN)|(1 << TXEN)|(1 << TXCIE)|(1 << RXCIE)
	out UCSRB,TEMP

	; Configure the clock generation mode
	; Configure the USART polarity mode 
	; The even parity will be used
	; Configure the stop bits
	; Configure the data bits = 9 bits for data
	ldi TEMP,(1 << URSEL)|(0 << UPM0)|(0 << UPM0)|(0 << UMSEL)|(1 << USBS)|(1 << UCSZ0)|(1 << UCSZ1)
	out UCSRC,TEMP
;======================USART_INIT=======================================


DATA_SENDING_SECTION:
	; In this section, the keypad will be analyzed to see if any button is pressed
	; Analayze the keypad
	; If nothing was pressed, jump to recieve data section
	; Check the keypad buttons press status
	call FIND_PRESSED
	call DATA_TRANSMIT
	rjmp DATA_SENDING_SECTION

;======TRANSMITTING THE DATA=======
DATA_TRANSMIT:
	; Load the row*16+col into the DATA_TO_BE_SENT
	lsl row
	lsl row 
	lsl row 
	lsl row 
	add row,col
	mov DATA_TO_BE_SENT,row
	; Wait for the UDRE to get set(UDR CLEARED)
	sbis UCSRA,UDRE
	rjmp DATA_TRANSMIT
	; Do a simple parity check before sending data
	; This is not optional because the parity bit will be send with other 8 bits as bit #9
	;call TRANSMITTER_PARITY_CHECK
	; Copy 9th bit from r17 to TXB8
	cbi UCSRB,TXB8
	; Enable USART send and recieve + Their interrupts
	out UDR,DATA_TO_BE_SENT
	; Data is now being sent
	ret
;======TRANSMITTING THE DATA=======


;===========FIND KEY===============
FIND_PRESSED:
	
FIND_COL:
	; Configure the DDRC
	ldi TEMP,0x0F
	out DDRC,TEMP

	; Configure the pull-ups
	; The ones that are input will be set as pull-up
	ldi TEMP,0xF0
	out PORTC,TEMP

	; Find the column easily by checking the PINC high bits
	sbis PINC,4
	ldi COL,1
	sbis PINC,5
	ldi COL,2
	sbis PINC,6
	ldi COL,3
	sbis PINC,7
	ldi COL,4

FIND_ROW:
	; Configure the DDRC
	ldi TEMP,0xF0
	out DDRC,TEMP

	; Configure the PORTC low bits pull-up
	ldi TEMP,0x0F
	out PORTC,TEMP
	
	; Find the row easily by checking the PINC low bits
	sbis PINC,0
	ldi ROW,1
	sbis PINC,1
	ldi ROW,2
	sbis PINC,2
	ldi ROW,3
	sbis PINC,3
	ldi ROW,4
	; now we have the pressed key row and column return to main routine
	ret
;===========FIND KEY===============


;========DISPLAY RECIEVED==========
DISPLAY_RECIEVED:
	; The input character is in the temp register now
	; load it into the argument of the LCD 
	mov argument,TEMP
	call lcd_putchar
	ldi argument,'A'
	call LCD_putchar
	ret
;========DISPLAY RECIEVED==========


;======================MAIN PROGRAM=====================================



;======================TRANSMITTER PARITY CHECK=========================
TRANSMITTER_PARITY_CHECK:
	; Get the internals of the UDR 
	; Simpley xor the result together
	; The final parity result will be saved in the RXB8 and TXB8
	; Loop through all the bits in the TXB
	; change the parity according to what you see
BIT_LOOPER:
	; Check first bit
	sbis UDR,0
	call PARITY_ON

	; Check second bit
	sbis UDR,1
	call PARITY_OFF

	; Check third bit
	sbis UDR,2
	call PARITY_ON

	; Check fourth bit
	sbis UDR,3
	call PARITY_OFF

	; Check fifth bit
	sbis UDR,4
	call PARITY_ON

	; Check sixth bit
	sbis UDR,5
	call PARITY_OFF

	; Check seventh bit
	sbis UDR,6
	call PARITY_ON
		
	; Check eighth bit
	sbis UDR,7
	call PARITY_OFF

PARITY_ON:
	; change the parity to 1
	ldi TEMP,(1 << TXB8)
	out UCSRB,TEMP
	ret

PARITY_OFF:
	; change the parity to 0
	ldi TEMP,(0 << TXB8)
	out UCSRB,TEMP
	ret
	
	; Go out of transmitter parity check
	ret
;======================TRANSMITTER PARITY CHECK=========================
