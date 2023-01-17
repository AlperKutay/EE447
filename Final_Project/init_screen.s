DATA_PORTA				EQU	0x400043FC	
DATA_PORTB				EQU	0x400053FC	
SSI0SR					EQU	0x4000800C	
SSI0DR					EQU	0x40008008


					AREA   main, CODE, READONLY
					THUMB
						
					EXTERN  DELAY100
					EXTERN	CursorSettings
					EXTERN	printR2Hex
					EXPORT	init_screen
						
init_screen			PUSH	{LR}

					LDR		R1,=DATA_PORTA	
					LDR		R2,[R1]
					MOV		R0,#0x7F			;Reseting 0x0111 1111 And with portA
					AND		R2,R0
					STR		R2,[R1]	
					
					BL 		DELAY100
					
					LDR		R1,=DATA_PORTA	
					LDR		R2,[R1]
					MOV		R0,#0x80			;Reseting 0x1000 0000 or with PortA
					ORR		R2,R0
					STR		R2,[R1]		
					
					LDR		R1,=DATA_PORTA		;Command Mode
					LDR		R0,[R1]
					AND		R0,0xBF 			;0x1011 1111
					STR		R0,[R1]
					
					MOV		R5,#0x21			;H=1, V=0
					BL		WritetoDR
					
					MOV		R5,#0xB0			;Vop
					BL		WritetoDR	
					
					MOV		R5,#0x04			;temperature coefficient
					BL		WritetoDR
					
					MOV		R5,#0x13			;Bias adjustment
					BL		WritetoDR				
					
					MOV		R5,#0x20			;H=0
					BL		WritetoDR
					
					MOV		R5,#0x0C			;H=0
					BL		WritetoDR
					
					
					
					MOV		R5,#0x80			;Adress of X=0
					BL		WritetoDR
			
					MOV		R5,#0x40			;Adress of Y=0
					BL		WritetoDR
					
					;BL		Clear_Screen
					
					BL		wait
					POP		{LR}
					BX		LR
					
					

WritetoDR			PUSH	{LR}
					BL		wait
					LDR		R1,=SSI0DR
					STRB	R5,[R1]
					POP		{LR}
					BX		LR
					


wait				LDR		R1,=SSI0SR
					LDR		R0,[R1]
					ANDS	R0,#0x10
					BNE		wait
					BX		LR
					
						
Clear_Screen		PUSH	{R0-R9,LR}
					MOV		R5,#0x80
					BL		WritetoDR
					
					MOV		R5,#0x40
					BL		WritetoDR
					
					LDR		R1,=DATA_PORTA		;Data mode on
					LDR		R0,[R1]
					ORR		R0,#0x40
					STR		R0,[R1]
					
					MOV		R2,#0x00		;counter to count all bits
					MOV		R5,#0x00		;Data Register to clear whole screen
					
loop6				BL		WritetoDR
					ADD		R2,#1
					CMP		R2,#504
					BNE		loop6
					POP		{R0-R9,LR}
					
					BX		LR
					END
					