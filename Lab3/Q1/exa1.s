			AREA    	main, READONLY, CODE
			THUMB
			EXPORT		__main  


PC5 EQU 0x40006080
GPIO_PORTC_DIR_R EQU 0x40006400
GPIO_PORTC_AFSEL_R EQU 0x40006420
GPIO_PORTC_DEN_R EQU 0x4000651C
SYSCTL_RCGC2_R EQU 0x400FE108
SYSCTRL EQU 0xE000E010


__main		
			BL 			INIT_TIMER
			BL 			INIT_GPIO
LOOP 		ADD			R3,#1
			B			LOOP
			ENDP
INIT_TIMER
			LDR 		R0, =SYSCTRL
			MOV 		R1, #0
			STR			R1, [R0] ; stop counter to prevent
			;interrupt triggered accidentally
			LDR 		R1, =20 ; trigger every 12000000 cycles
			STR 		R1, [R0,#4]
			STR 		R1, [R0,#8]
			MOV 		R1, #0x3
			STR 		R1, [R0] ; enable interrupt, enable SYSTICK counter
			; clk source:PIOSC/4=4MHz
			BX 			LR
INIT_GPIO
			LDR 		R1, =SYSCTL_RCGC2_R
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x04 ; clock PortC
			STR 		R0, [R1]
			NOP
			NOP
			LDR 		R1, =GPIO_PORTC_DIR_R
			LDR 		R0, [R1]
			ORR			R0, R0, #0x20
			STR			R0, [R1]
			LDR 		R1, =GPIO_PORTC_AFSEL_R
			LDR			R0, [R1]
			BIC 		R0, R0, #0x20
			STR 		R0, [R1]
			LDR 		R1, =GPIO_PORTC_DEN_R
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x20
			STR 		R0, [R1]
			BX 			LR
SysTick_Handler
			EXPORT SysTick_Handler
			LDR 		R0, =PC5 ; GPIOC
			MOV 		R1, 0x20
			LDR 		R2, [R0]
			EOR 		R2, R2, R1
			STR 		R2, [R0]
			BX			LR
			END