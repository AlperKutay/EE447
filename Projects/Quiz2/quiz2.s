			AREA    	main, READONLY, CODE
			THUMB
			EXPORT  	__main
				
__main		PROC
			LDR			R0,=0x0F
			LDR			R4,=0xF0000000
			LDR			R1,=0xAD
			
			ASR			R3,R4,#2
			
			MOV			R5,#5
			ENDP
			END
			
			