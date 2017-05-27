;
; USART_RECIEVER.asm
;
; Created: 5/27/2017 7:54:22 AM
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
	ldi ROW,100

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
RECIEVE_DATA_SECTION:
	; Simply grab the data from the usart input 
	; Tha DATA_RECIEVE routine has to be called all the time
	call DATA_RECIEVE
	; The result of the DATA_RECIEVE will be displayed on the LCD
	call DISPLAY_RECIEVED

;======RECIEVING THE DATA==========
DATA_RECIEVE:
	; Wait for the data to be recieved 
	sbis UCSRA,RXC
	rjmp DATA_RECIEVE
	ldi argument,'A'
	call LCD_putchar
	; Get the status and 9th bit, then the data from buffer
	in RECIEVE_STATUS,UCSRA
	in TEMP2,UCSRB
	in TEMP,UDR
	; If error, return -1
	andi r18,(1 << FE)|(1 << DOR)
	breq USART_ReceiveNoError

	ldi TEMP2, HIGH(-1)
	ldi TEMP, LOW(-1)
USART_ReceiveNoError:
	; Filter the 9th bit, then return
	lsr TEMP2
	andi TEMP2, 0x01
	ret
;======RECIEVING THE DATA==========

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


;======================DELAY=========================
;======================DELAY=========================

