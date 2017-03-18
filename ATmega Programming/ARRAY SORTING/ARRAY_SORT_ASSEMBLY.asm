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
	/* R16 will be incremented each time we loop through the outer loop */
	mov R16,ARRAY
OUTER_LOOP:
	
INNER_LOOP:
	/* we need to keep track of two words each time we loop through the INNER_LOOP */
	/* Take a copy of R16 (starting point of the main loop) in R17 */
	mov R17,R16;
	inc R17;
	mov R18,R17;
	dec R17;
	/* Now we have that (n)th and that (n+1)th element address in R17 and R18 respectively :D */
	/* Get the contents of R17 and R18 for comparison from that memory */
	/* The content of program memory of address R17 and R18 will be stored in R19 and R20 for comparison */
	/* use the LPM instruction to read those addresses */

	/* load R19 with the content from address R17 in program memory */
	lpm R19,R17
	/* load R20 with the content from address R18 in program memory */
	lpm R20,R18

	/* Compare the result */
	/* R19 = (n)th element & R20 = (n+1)th element */
	cp R20,R19
	/* swap if R20 is greater than R19 */
	swap






	/* Increment the R16 */
	inc R16
	/* Compare the R16 value with immediate 99 (100 elements) */
	cp
	/* Branch to the OUTER_LOOP if we havent reached the end yet */
	brne
    rjmp start 
