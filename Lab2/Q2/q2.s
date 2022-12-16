					AREA    	main, READONLY, CODE
					THUMB
					EXTERN		DELAY150
					EXTERN		PB_INIT
					EXPORT  	__main


PB_INP				EQU	0x4000503C
PB_OUT				EQU	0x400053C0
GPIO_PORTB_DATA 	EQU 0x400053FC ; data a d d r e s s t o a l l pi n s
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL 	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PDR		EQU	0x40005514
GPIO_PORTB_PUR 		EQU 0x40005510
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; these are written in Week-6 Lecture Notes page 58
	
__main				PROC;
					BL          PB_INIT						
nanInp				LDR			R1,=GPIO_PORTB_DATA
					LDR			R0,[R1]
					LSR			R5,R0,#4
					LDR 		R0,[R1]
					CMP			R5,#0xE
					BEQ			LED1
					CMP			R5,#0xD
					BEQ			LED2
					CMP			R5,#0xB
					BEQ			LED3
					CMP			R5,#0x7
					BEQ			LED4
					BL			DELAY150
					B			nanInp
LED1				MOV			R2,R5	;E
					LDR			R1,=GPIO_PORTB_DATA
					STR			R2,[R1]
					B			nanInp

LED2				MOV			R2,R5 ;D
					LDR			R1,=GPIO_PORTB_DATA
					STR			R2,[R1]
					B			nanInp
					
LED3				MOV			R2,R5
					LDR			R1,=GPIO_PORTB_DATA
					STR			R2,[R1]
					B			nanInp

LED4				MOV			R2,R5
					LDR			R1,=GPIO_PORTB_DATA
					STR			R2,[R1]
					B			nanInp
					
					ALIGN
					ENDP
					END