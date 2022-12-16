			AREA    	main, READONLY, CODE
			THUMB
			EXTERN 		OutChar
			EXPORT		__main  	
				
__main		PROC;
			PUSH		{R8}			;To keep data in register8 same	
			MOV32		R8,#600000		;Since each loop takes 4 cycles. # of iteration should be 2.400.000/4 = 600000.
;Since its clock is 16MHz. Each cycle will take 0.06us (1/16M sec) to operate
;To take 150ms (0.15 sec = 1.5*10^5 us),
;It should take (0.15sec)/((1/16M)sec) =2.4M cycle 
delaying	NOP							;Taking 1 cycle
			SUBS		R8,#1 			;Taking 1 cycle
			BNE			delaying		;Taking 2 cycle
			POP			{R8}
			BX			LR
			ALIGN
			END