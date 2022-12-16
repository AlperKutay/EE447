			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		InChar	; Reference external subroutine	
			EXTERN		CONVRT; Make available
			EXTERN		OutStr; Make available
			EXPORT  	__main
NUM 		EQU			0x20000480

__main		PROC
start		BL 			InChar
			MOV    		R4,R0	;Temp value 1
			LDR			R1,=0x0 ;Temp value 2
			LDR			R2,=0x0 ;Temp value 3
			LDR			R3,=0xA	;Since we are converting hex to decimal. It's based is 10 ( Hexa [A]= Deci [10])
			LDR			R5,=0x20000480	;Address value that will be written ASCII Value
			LDR			R9,=0x10
			MOV			R6,R5
			BL			CONVRT
			LDR			R0,=0x20000480
			BL 			OutStr
			BL			InChar
			B			start
forever		B			forever

			ALIGN
			ENDP
			END