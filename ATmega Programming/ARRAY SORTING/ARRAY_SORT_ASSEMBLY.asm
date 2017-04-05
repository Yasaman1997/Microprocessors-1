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

OUTER_LOOP:
	
INNER_LOOP:
	/* we need to keep track of two words each time we loop through the INNER_LOOP */
	/* Take a copy of R16 (starting point of the main loop) in R17 */
	lpm R17,Z;
	inc R17;
	mov R18,R17;
	dec R17;
	/* Now we have that (n)th and that (n+1)th element address in R17 and R18 respectively :D */
	/* Get the contents of R17 and R18 for comparison from that memory */
	/* The content of program memory of address R17 and R18 will be stored in R19 and R20 for comparison */
	/* use the LPM instruction to read those addresses */

	/* load R19 with the content from address R17 in program memory */
	mov R19,R17
	/* load R20 with the content from address R18 in program memory */
	mov R20,R18

	/* Compare the result */
	/* R19 = (n)th element & R20 = (n+1)th element */
	cp R20,R19
	/* swap if R20 is greater than R19 */
	swap
	/* Its better to define a subroutine to put the R20 in place (n)th in memory and the R19 to (n+1)th place */

	/* Check if we have reached the end of the inner_loop */
	/* Compare the R20 value with the address of 99 elements later from ARRAY (must be defined above) */
	cp R20,
	brne INNER_LOOP

	/* Increment the R16 */
	inc R16
	/* Compare the R16 value with immediate 99 (100 elements) */
	cp
	/* Branch to the OUTER_LOOP if we havent reached the end yet */
	brne
    rjmp start 
