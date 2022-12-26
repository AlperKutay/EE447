
			AREA    	main, READONLY, CODE
			THUMB
			EXPORT  	DELAY100



DELAY100	PROC;
			PUSH		{R0}
			MOV32		R0,#60000
return		SUBS		R0,#1
			NOP
			BNE			return
			POP			{R0}
			BX			LR
			ENDP
			END