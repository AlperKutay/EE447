GPIO_PORTB_DATA EQU 0x400053FC
GPIO_PORTB_DIR_R EQU 0x40005400
GPIO_PORTB_AFSEL_R EQU 0x40005420
GPIO_PORTB_DEN_R EQU 0x4000551C
GPIO_PORTB_PUR EQU 0x40005510
GPIO_PORTB_PDR EQU 0x40005514
SYSCTL_RCGC2_R EQU 0x400FE108
		AREA 		leds_prog, CODE, READONLY, ALIGN=2
		THUMB
		EXTERN 		delay
		EXPORT 		__main
PortB_Init
; activate clock
		LDR 		R1, =SYSCTL_RCGC2_R ; R1 = &SYSCTL_RCGC2_R
		LDR 		R0, [R1]
		ORR 		R0, R0, #0x02;turn on clock for port A
		STR			R0, [R1]
		NOP
		NOP ; allow time to finish activating; set direction register
		LDR 		R1, =GPIO_PORTB_DIR_R ; R1 = &GPIO_PORTB_DIR_R
		LDR 		R0, [R1]
		BIC 		R0, R0, #0xF0 ; make PB7-4 INPUT
		ORR 		R0, R0, #0x0F ; make PB3-0 OUTPUT
		STR 		R0, [R1]
; regular port function
		LDR 		R1, =GPIO_PORTB_AFSEL_R ; R1 = &GPIO_PORTB_AFSEL_R
		LDR 		R0, [R1]
		BIC 		R0, R0, #0xFF ; disable alt funct,
		STR 		R0, [R1]
		; pull-downresistors on switch pins

		
		LDR 		R1, =GPIO_PORTB_PUR
		MOV 		R0, #0xF0;pull downon pins 0-3 of PORT B
		STR 		R0, [R1]; enable digital port
		
		LDR 		R1, =GPIO_PORTB_DEN_R ; R1 = &GPIO_PORTB_DEN_R
		LDR 		R0, [R1]
		ORR 		R0, R0, #0xFF ; enable digital I/O on PB
		STR			R0, [R1]
		BX			LR
__main
		BL 			PortB_Init
loop	

		LDR 		R1, =GPIO_PORTB_DATA
		LDR			R0,[R1]
		MOV32		R10,#6000000
		BL			delay
		LSR			R0,R0,#4
		STR			R0,[R1]
		
		B 			loop


		ALIGN
		; make sure the end of this section is aligned
		END ; end of file