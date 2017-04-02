;
; LED_WATCHDOG.asm
;
; Created: 4/2/2017 9:45:43 AM
; Author : Ali Gholami
;
; A program to turn the LED on by pressing a key and wait for another key to prevent the WDT from reseting it
; so it will keep alive all the time (button press must be less than 2.1s)
; in case the LED goes off, we can enable it by pressing that first key 

; Replace with your application code
start:
    /* set the PINB0 data direction to 0 for input */
	/* This one simulates the key */
	ldi R16, 0x01	; Load 0b00000001 in R16
    out DDRB,R16	; Configure the PINB0 as input

	/* set the PINB1 data direction to 0 for input */
	/* This one simulates the key */
	/* This key will work as WDR */
	clr R16			; Clear the R16
	ldi R16, 0x02	; Load 0b00000020 in R16
    out DDRB,R16	; Configure the PINB1 as input

	/* set the PORTB data direction to 1 for output */
	/* this one causes the LED to be ON/OFF */
	ldi R17, 0x80	; Load 0b10000000 in R17
	out DDRB,R17	; Configure the PORTB7 as output

    rjmp start
