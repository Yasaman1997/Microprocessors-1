;
; ADC_PRAC.asm
;
; Created: 5/18/2017 1:05:30 AM
; Author : aligholamee
;


.def adcLow=r21
.def adcHigh=r22
.def maxVL=r23
.def maxVH=r24
.def minVL=r25
.def minVH=r26
.def compRes=r27
.def counter=r28
.def counter2=r29
.include "m16_LCD_4bit.inc"
; Replace with your application code
.org 0x001c
intrupt:
	/*cpi r30,0x00
	breq x1
	ldi r30,0xff
	rjmp x2
	x1:ldi r30,0xff
	x2:out portb,r30*/
	ldi r16,(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)|(1<<ADATE)|(1<<ADIE)
	out ADCSRA,r16
	sei
	rjmp continue
start:
init:
	ldi counter,0x00
	ldi r16,low(ramend)
	out spl,r16
	ldi r16,high(ramend)
	out sph,r16
	ldi r16,(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)|(1<<ADATE)|(1<<ADIE)
	out ADCSRA,r16
	sei
	ldi r16,0x00
	out ddrb,r16
	ldi r16,0xff
	out ddrc,r16
	call readMinSensor
	call readMaxSensor
	rjmp again
again:
	call readHSensor
	call compHigh
	cpi compRes,0x01
	breq light1On
	call compLow
	cpi compRes,0x00
	breq lightOff
	cpi compRes,0x02
	breq light2On
light1On:
	ldi r16,0x01
	out portc,r16
	rjmp end
light2On:
	ldi r16,0x02
	out portc,r16
	rjmp end
lightOff:
	ldi r16,0x00
	out portc,r16
	rjmp end
compHigh:
	cp adcHigh,maxVH
	brlo normalH
	cp adcLow,maxVL
	brlo normalH
	ldi  compRes,0x01
	ret
normalH:
	ldi compRes,0x00
	ret
compLow:
	cp minVH,adcHigh
	brlo normalL
	cp minVL,adcLow
	brlo normalL
	ldi  compRes,0x02
	ret
normalL:
	ldi compRes,0x00
	ret
end:
	inc counter
	cpi counter,0xff
	breq showLed
	rjmp again
showLed:
	CALL LCD_INIT
	CALL LCD_WAIT
	ldi counter,0x00
;	call reset
;	cpi lcdhigh,0x03
;	brlo show3
part2:
	cpi adcLow,0x0a
	brlo show10
	cpi adcLow,0x14
	brlo show20
	cpi adcLow,0x1e
	brlo show30
	cpi adcLow,0x28
	brlo show40
	cpi adcLow,0x32
	brlo show50
	cpi adcLow,0x3c
	brlo show60
	cpi adcLow,0x46
	brlo show70
	cpi adcLow,0x50
	brlo show80
	cpi adcLow,0x64
	brlo show90
end2:
	rjmp again
show10:
	ldi argument,'1'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show20:
	ldi argument,'2'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show30:
	ldi argument,'3'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show40:
	ldi argument,'4'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show50:
	ldi argument,'5'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show60:
	ldi argument,'6'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show70:
	ldi argument,'7'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show80:
	ldi argument,'8'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

show90:
	ldi argument,'9'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	rjmp end2

wait:
	ldi r16,(1<<ADSC)
	in r17,ADCSRA;ADSC
	and r16,r17
	cpi r16,(1<<ADSC)
	breq wait
	ret
readHSensor:
	ldi r16,0x00
    out ADMUX,r16
	in r16,ADCSRA
	ori r16,(1<<ADSC)
	out ADCSRA,r16
	in r16,MCUCR
	ori r16,(1<<SE)|(1<<SM0)|(0<<SM1)|(0<<SM2)
	out MCUCR,r16
	sleep
	continue:
		in adcLow,ADCL
		in adcHigh,ADCH
		ret
readMaxSensor:
	ldi r16,0x01
    out ADMUX,r16
	in r16,ADCSRA
	ori r16,(1<<ADSC)
	out ADCSRA,r16
	call wait
	in maxVL,ADCL
	in maxVH,ADCH
	out portc,maxVL
	ret
readMinSensor:
	ldi r16,0x02
    out ADMUX,r16
	in r16,ADCSRA
	ori r16,(1<<ADSC)
	out ADCSRA,r16
	call wait
	in minVL,ADCL
	in minVH,ADCH
	ret
