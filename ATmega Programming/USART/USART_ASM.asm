;
; USART_ASM.asm
;
; Created: 5/21/2017 9:32:59 PM
; Author : aligholamee
;
; Program to connect the atmega16 with the virtual DB9 port through MAX232

.def TEMP = R16
.def F_OSC = R17
.def BAUD_HIGH = R18	
.def BAUD_LOW = R19
.def TEMP2 = R20
.def BIT_CNT = R21
;======================VECTORS==========================================
.org 0x00
	jmp RESET_ISR


;======================VECTORS==========================================

;======================RESET_ISR========================================
RESET_ISR:
	; Config the stack pointer
	ldi TEMP,HIGH(RAMEND)
	out SPH,TEMP
	ldi TEMP,LOW(RAMEND)
	out SPL,TEMP

	; Set the baud rate to 4800 bps
	ldi BAUD_LOW,12
	ldi BAUD_HIGH,0
	; Configure the baud rate
	out UBRRH,BAUD_HIGH
	out UBRRL,BAUD_LOW

	; Configure the clock generation mode
	; Configure the USART polarity mode 
	; The even parity will be used
	; Configure the stop bits
	; Configure the data bits = 9 bits for data
	ldi TEMP,(1 << URSEL)|(0 << UPM0)|(0 << UPM0)|(0 << UMSEL)|(1 << USBS)|(1 << UCSZ0)|(1 << UCSZ1)
	out UCSRC,TEMP
	; Enable USART send and recieve + Their interrupts
	ldi TEMP,(1 << UCSZ2)|(1 << RXEN)|(1 << TXEN)|(1 << TXCIE)|(1 << RXCIE)
	out UCSRB,TEMP
	; Enable global interrupts
	sei
;======================RESET_ISR========================================

;======================MAIN PROGRAM=====================================
start:
	rjmp start
;======================MAIN PROGRAM=====================================



;======================TRANSMITTER PARITY CHECK=====================================
TRANSMITTER_PARITY_CHECK:
	; Get the internals of the UDR 
	; Simpley xor the result together
	; The final parity result will be saved in the RXB8 and TXB8
	ldi TEMP,TXB
	; Loop through all the bits in the TXB
	; change the parity according to what you see
BIT_LOOPER:
	; Check first bit
	sbis TXB,0
	call PARITY_ON

	; Check second bit
	sbis TXB,1
	call PARITY_OFF

	; Check third bit
	sbis TXB,2
	call PARITY_ON

	; Check fourth bit
	sbis TXB,3
	call PARITY_OFF

	; Check fifth bit
	sbis TXB,4
	call PARITY_ON

	; Check sixth bit
	sbis TXB,5
	call PARITY_OFF

	; Check seventh bit
	sbis TXB,6
	call PARITY_ON
		
	; Check eighth bit
	sbis TXB,7
	call PARITY_OFF

PARITY_ON:
	; change the parity to 1
	ldi TEMP2,(1 << TXB8)
	out UCSRB,TEMP
	ret

PARITY_OFF:
	; change the parity to 0
	ldi TEMP2,(0 << TXB8)
	out UCSRB,TEMP
	ret
	
	; Go out of transmitter parity check
	ret
;======================TRANSMITTER PARITY CHECK=====================================
