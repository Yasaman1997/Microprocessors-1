;
; ARRAY_SORT_ASSEMBLY.asm
;
; Created: 3/18/2017 7:02:47 PM
; Author : Ali Gholami
;


; Replace with your application code
start:
	/* Using bubble sort to sort the array */
	/* The data is pre-written into the ARRAY label in the program memory */ 
	/* So we can access the ARRAY address by writing array in any instruction */
	/* To use the bubble sort we need to have the (n)th and (n+1)th element of the array every time we loop through the array */
	/* So we need one loop until now */
	/* Then we need to move the starting point of those bubble like check one step further (deeper) each time */
	/* So we would need another loop to do that */
	/* Overall we need 2 embedded loops to do this */

	/* Now copy the address of the array into the register R16 */
	/* Z will be incremented each time we loop through the outer loop */
	/* Make sure the Z pointer is initialized before getting into the loops */
	/* INITIALIZE Z POINTER */
	ldi ZH,high(ARRAY << 1)
	ldi ZL,low(ARRAY << 1)

	/* Initialize counters */
	ldi R16,100
OUTER_LOOP:
	/* Initialize counters */
	ldi R20,100
INNER_LOOP:
	/* we need to keep track of two words each time we loop through the INNER_LOOP */
	/* Take a copy of Z (starting point of the main loop) in 24 */
	mov R24,Z

	/* Load Z and Z+ contents into R17 and R18 for comparison */
	lpm R17,Z+;
	lpm R18,Z;
	/* Now we have that (n)th and that (n+1)th element value in R17 and R18 respectively :D */
	/* Compare the result */
	/* R19 = (n)th element & R20 = (n+1)th element */
	cp R17,R18
	brlt SWAP_ROUTINE
	/* Its better to define a subroutine to put the R20 in place (n)th in memory and the R19 to (n+1)th place */

	/* Check if we have reached the end of the inner_loop */
	dec R20
	brne INNER_LOOP

	/* decrement the R16 */
	dec R16
	/* Check if we have reached the end of the outer_loop */
	/* Branch to the OUTER_LOOP if we havent reached the end yet */
	brne OUTER_LOOP
    rjmp start 

SWAP_ROUTINE:
	/* Change the content of R17 and R18 addresses */
	/* We have the address of R17 atm in R24 */
	/* We have the address of R18 in the Z pointer */
	/* We need to swap the contents of R17 and R18 */
	/* Create a temp register */
	mov R26,R18		;	Backup R18
	spm R17,Z		;	Swapping
	/* Put the R24(Copy of R17 address) in the Z */
	mov Z,R24
	spm R26,Z