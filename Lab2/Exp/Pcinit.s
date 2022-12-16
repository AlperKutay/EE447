					AREA    	main, READONLY, CODE
					THUMB
					EXPORT  	PC_INIT


GPIO_PORTC_DATA 	EQU 0x400063FC ; data a d d r e s s t o a l l pi n s
GPIO_PORTC_DIR 		EQU 0x40006400
GPIO_PORTC_AFSEL 	EQU 0x40006420
GPIO_PORTC_DEN 		EQU 0x4000651C
GPIO_PORTC_PDR		EQU	0x40006514
GPIO_PORTC_PUR 		EQU 0x40006510
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; these are written in Week-6 Lecture Notes page 58
	
PC_INIT				PROC;
Start				LDR 		R1,=SYSCTL_RCGCGPIO ;Clock Enabled for GPIO B
					LDR 		R0,[R1]
					ORR 		R0,R0,#0x4
					STR 		R0,[R1]
					NOP
					NOP
					NOP 
					LDR 		R1,=GPIO_PORTC_DIR 
					LDR 		R0, [R1]
					ORR 		R0, R0, #0x0F 		; make PB7-4 input
					BIC 		R0, R0, #0xF0 		; make PB3-0 output
					STR 		R0, [R1] 
					LDR 		R1,=GPIO_PORTC_AFSEL
					LDR 		R0,[R1]
					BIC 		R0,#0xFF 			;disable alt funct, 
					STR 		R0,[R1]
					LDR 		R1,=GPIO_PORTC_DEN ;Enable digital port
					LDR 		R0,[R1]
					ORR 		R0,#0xFF			;enable digital I/O on PB
					STR			R0,[R1]
					;LDR			R1,=GPIO_PORTC_PDR ;pull-down resistors on switch pins
					;LDR			R0,[R1]
					;ORR			R0,#0xF0			;pull down on pins 0-3 of PORT B
					;STR 		R0,[R1]
					BX			LR
					ALIGN
					END