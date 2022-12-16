			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		OutStr	
			EXTERN		InChar
			EXTERN		CONVRT
			EXPORT  	__main
NUM2		EQU			0x20000600
NUM			EQU			0x20000400
__main		PROC;TAKING DATA AS WITH TWO DIGITS
			LDR			R3,=0xA			
			LDR			R9,=NUM2
			BL    		InChar	
			PUSH		{R0}
			BL			InChar
			POP			{R7}
			SUB			R7,#0x30
			SUB			R0,#0x30
			MUL			R7,R3
			ADD			R0,R7 ; R0 represents input value with decimal
			;Prepreation for the alghoritm
			MOV			R2,R0
			BL 			InChar
			MOV			R0,R2
			MOV			R2,#0x31 ; Represents Fn-1
			MOV			R3,#0x31 ; Represents Fn-2
			SUB			R0,#2
			STR			R2,[R9],#1
			STR			R3,[R9],#1
			MOV			R2,#1 ; Represents Fn-1
			MOV			R3,#1 ; Represents Fn-2
			BL			fibo  ;It writes mFibo Values to the NUM adress
final		LDR			R10,=0x0D
			STR			R10,[R9],#1
			LDR			R10,=0x04
			STR			R10,[R9],#1
			LDR			R0,=NUM2
			BL			OutStr
			B			__main
			ALIGN 
			ENDP

fibo		PROC
			LDR			R5,=NUM
			MOV			R6,R5
			LSL			R8,R3,#1
			ADD			R7,R2,R8
			MOV			R3,R2
			MOV			R2,R7
			MOV			R4,R2
			CMP			R4,#10
			BMI			fibo2
			PUSH		{R0,R2,R3,R7}
			BL			CONVRT
			POP			{R0,R2,R3,R7}
			SUBS		R0,#1
			BPL			fibo
			B			final


fibo2		ADD			R4,R4,#48
			STR			R4,[R9],#1
			SUBS		R0,#1
			B			fibo