;
; WDT_INIT.asm
;
; Created: 4/2/2017 9:01:52 AM
; Author : Ali Gholami
;
; A program to initialize the watchdog timer and configure it for a 2.1 second reset timer.
; This program will cause the WDT to be reseted after 2.1 if we dont reset it manualy.

; Replace with your application code
start:
    inc r16
    rjmp start
