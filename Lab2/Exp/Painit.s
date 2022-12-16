					AREA    	main, READONLY, CODE
					THUMB
					EXPORT  	PA_INIT


GPIO_PORTA_DATA 	EQU 0x400043FC ; data a d d r e s s t o a l l pi n s
GPIO_PORTA_DIR 		EQU 0x40004400
GPIO_PORTA_AFSEL 	EQU 0x40004420
GPIO_PORTA_DEN 		EQU 0x4000451C
GPIO_PORTA_PDR		EQU	0x40004514
GPIO_PORTA_PUR 		EQU 0x40004510
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; these are written in Week-6 Lecture Notes page 58
	
PA_INIT				PROC;
Start				LDR 		R1,=SYSCTL_RCGCGPIO ;Clock Enabled for GPIO B
					LDR 		R0,[R1]
					ORR 		R0,R0,#0x1
					STR 		R0,[R1]
					NOP
					NOP
					NOP 
					LDR 		R1,=GPIO_PORTA_DIR 
					LDR 		R0, [R1]
					ORR 		R0, R0, #0x0F 		; make PB7-4 input
					BIC 		R0, R0, #0xF0 		; make PB3-0 output
					STR 		R0, [R1] 
					LDR 		R1,=GPIO_PORTA_AFSEL
					LDR 		R0,[R1]
					BIC 		R0,#0xFF 			;disable alt funct, 
					STR 		R0,[R1]
					LDR 		R1,=GPIO_PORTA_DEN ;Enable digital port
					LDR 		R0,[R1]
					ORR 		R0,#0xFF			;enable digital I/O on PB
					STR			R0,[R1]
					LDR			R1,=GPIO_PORTA_PDR ;pull-down resistors on switch pins
					LDR			R0,[R1]
					ORR			R0,#0xF0			;pull down on pins 0-3 of PORT B
					STR 		R0,[R1]
					BX			LR
					ALIGN
					END