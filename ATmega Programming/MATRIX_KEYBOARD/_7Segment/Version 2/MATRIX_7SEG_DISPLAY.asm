;
; KEYPAD_7SEGMENT_VER2.asm
;
; Created: 4/23/2017 9:56:49 AM
; Author : Ali Gholami
;


; This application will enable the interrupts of atmega by pressing each keypad button
start:
    inc r16
    rjmp start
