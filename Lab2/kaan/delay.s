			AREA		routines, READONLY, CODE
			THUMB
			EXPORT		delay
				
delay
again		PROC
			NOP
			NOP
			SUBS		R10,R10,#1
			BNE			again
			BX			LR
			ENDP
				