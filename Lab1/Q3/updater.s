			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		InChar	; Reference external subroutine	
			EXPORT  	UPBND	; Make available

UPBND		PROC
start		PUSH		{R2,R3,R4,R5,R6,LR}			
geta		BL    		InChar
			CMP			R0,#0x43 ; if input == 'C'
			BEQ			forever  ; Finalize and go to infinite loop
			CMP			R0,#0x55 ; if input == 'U'
			BEQ			chLW	; Change lower bound
			CMP			R0,#0x44 ; if input == 'D'
			BEQ			chHG	; Change upper bound
			B			geta
forever		B			forever
			ENDP

chLW		PROC
			MOV			R10,R12
			POP			{R2,R3,R4,R5,R6,LR}
			BX			LR

chHG		PROC
			MOV			R11,R12
			POP			{R2,R3,R4,R5,R6,LR}
			BX			LR
			ENDP	


			END