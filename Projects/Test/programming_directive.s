            AREA        main, READONLY, CODE
            THUMB
            EXPORT      __main      ; Make available
__main 		
start       LDR R0, =0x20000040; Set the address of the length to R0
			LDR R1, [R0], #4; R1 in COUNT, RO is POINTER
			BFC R2, #0, #32; R2 and R3 to store SUM, R2 is least sig.
			BFC R3, #0, #32
			LDR R2, [R0], #4; Load the first number and increment 
POINTER
			SUBS R1, #1; Reduce COUNT by 1
			BEQ End; If COUNT is zero, branch to End
Loop		LDR R4, [R0], #4; Load the following #and increment POINTER
			ADDS R2, R4; Add the number to SUM’s least sig. word
			BCC Cont; If there is no carry, branch to Cont
			ADD R3, #1; else increment R3
Cont		SUBS R1, #1; Reduce COUNT by 1
			BEQ End; If COUNT is zero, branch to End
			B Loop
End			LDR R0, =0x20001000; Set the address of storage to R0
			STRD R2, R3, [R0]; Save R2 and then R3 starting from add.R0
Done		B Done; Loop at this instruction
			
			ALIGN
			END