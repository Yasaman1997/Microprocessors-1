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
    inc r16
    rjmp start
