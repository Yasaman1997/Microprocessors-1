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
	

	/* Increment the R16 */
	inc R16
    rjmp start 
