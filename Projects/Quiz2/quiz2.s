			AREA    	main, READONLY, CODE
			THUMB
			EXPORT  	__main
				
__main		PROC
			LDR			R0,=0x20000200
			LDR			R1,=0x1
			BL			SR1
			STR			R1,[R0]
done		B			done	


SR2			ADD			R1,R1,#10
			BX			LR	

SR1			MUL			R1,R1,#20
			PUSH		{LR}
			BL			SR2
			POP			{LR}
			BX			LR
			