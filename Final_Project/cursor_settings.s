DATA_PORTA			EQU	0x400043FC	

SSI0SR					EQU	0x4000800C	
SSI0DR					EQU	0x40008008


					AREA   main, CODE, READONLY
					THUMB
						

					EXPORT	CursorSettings

;This subroutine is helping to adjusting printing area
CursorSettings		PROC
					PUSH	{R0-R9,LR}
					LDR		R1,=DATA_PORTA		
					LDR		R0,[R1]
					BIC		R0,#0x40				;Command
					STR		R0,[R1]
					MOV		R5,#0x20				
					BL		WritetoDR					;H=0		
					MOV		R5,R10					
					ORR		R5,#0x80
					BL		WritetoDR					;X address
					MOV		R5,R11					
					ORR		R5,#0x40
					BL		WritetoDR					;Y address

					BL		wait

					LDR		R1,=DATA_PORTA		;Data mode on
					LDR		R0,[R1]
					ORR		R0,#0x40
					STR		R0,[R1]
					POP		{R0-R9,LR}
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
					ENDP
											