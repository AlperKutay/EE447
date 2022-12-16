			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		CONVRT
			EXTERN		OutStr
			EXTERN		InChar
			EXTERN		UPBND
			EXPORT  	__main
				
NUM			EQU			0x20000400				
				
				
				
__main		PROC;TAKING DATA AS WITH TWO DIGITS
			LDR			R3,=0xA
			LDR			R5,=NUM
			MOV			R6,R5
			BL    		InChar	
			PUSH		{R0}
			BL			InChar
			POP			{R7}
			SUB			R7,#0x30
			SUB			R0,#0x30
			MUL			R7,R3
			ADD			R0,R7 ; R0 represents input value with decimal
			;Prepreation for the alghoritm
			MOV			R10,#0;This will be held for minimum limit
			MOV			R11,#1; R11=1
			LSL			R11,R11,R0;This will be the maximum == 2^n
			
			
			
calcu		ADD			R12,R11,R10 ; R1=R11+R0 (MAX+MIN)
			LSR			R12,R12,#1 ; 	R1=R1/2		(MIN+MAX)/2
			MOV			R4,R12
			PUSH		{R5,R6}
			BL			CONVRT
			LDR			R0,=NUM
			BL			OutStr
			POP 		{R5,R6}
			BL			UPBND
			B			calcu
loop		B			loop
			ALIGN
			ENDP