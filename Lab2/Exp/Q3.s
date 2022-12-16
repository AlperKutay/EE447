					AREA    	main, READONLY, CODE
					THUMB
					EXTERN		DELAY125
					EXTERN		PB_INIT
					EXTERN		OutChar
					EXPORT  	numpad
WRITE				EQU	0x20000400							
GPIO_PORTB_DATA 	EQU 0x400053FC ; data a d d r e s s t o a l l pi n s
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL 	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PDR		EQU	0x40005514
GPIO_PORTB_PUR 		EQU 0x40005510
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; these are written in Week-6 

numpad				PROC         
start				LDR			R2,=GPIO_PORTB_DATA
					MOV			R3,#0xF0 			
					MOV			R0,#48				;Define R0 as 0 
					MOV			R7,#0
					STR			R3,[R2]
					LDR			R3,[R2]				;Debouncing Effect
					BL			DELAY125
					LDR			R4,[R2]
					CMP			R3,R4				;If there is no debouncing , continue
					BNE			start
					LSR			R5,R3,#4			;in this part of the code we search row and colum in only one loop
					CMP			R5,#0xD				;to determine the number of button we use column number
					ADDEQ		R0,#1				;if pressed button is in R1 we add to R2 1
					CMP			R5,#0xB				;if pressed button is in R1 we add to R3 2
					ADDEQ		R0,#2
					CMP			R5,#0x7				;if pressed button is in R1 we add to R4 3
					ADDEQ		R0,#3
					CMP			R5,#0xF				;Determine button is being pressed
					BNE			ROW_finder			;If there is button pressed continue
					B			start
					ALIGN
					ENDP
						
ROW_finder			MOV			R6,#0x7				;ROW1 Which means L4 
					STR			R6,[R2]
					NOP
					NOP
					NOP
					LDR			R7,[R2]
					LSR			R7,R7,#4			;Output is taken
					CMP			R7,R5				;If output is same with R5 we can assure it is true
					ADDEQ		R0,#12				;Since we are on L4, we should add 12 to the R0
					MOV			R6,#0xB;			;Same process continues
					STR			R6,[R2]
					NOP
					NOP
					NOP
					LDR			R7,[R2]
					LSR			R7,R7,#4
					CMP			R7,R5
					ADDEQ		R0,#8	
					MOV			R6,#0xD
					STR			R6,[R2]
					NOP
					NOP
					NOP
					LDR			R7,[R2]
					LSR			R7,R7,#4
					CMP			R7,R5
					ADDEQ		R0,#4  
					MOV			R6,#0xE
					STR			R6,[R2]
					NOP
					NOP
					NOP
					LDR			R7,[R2]
					LSR			R7,R7,#4
					CMP			R7,R5
					ADDEQ		R0,#0
					LDR			R8,=0xF0
					STR			R8,[R2]
					NOP
					NOP
					NOP
out					LDR			R9,[R2]				;This function determines the if button is keep being pressed or not
					NOP
					NOP
					NOP
					CMP			R9,R8
					BNE			out
					CMP			R0,#58				;We have done lots of addition but we did not take care of letters. If R0 ig bigger that 9+48, we should add 7 to get letters
					POP			{LR}
					BCC			noletter
					ADD			R0,#7
noletter			BL			OutChar
					PUSH		{LR}
					BX			LR				
					ALIGN 
					END
					