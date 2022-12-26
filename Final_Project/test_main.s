/*SYSCTRL				EQU			0xE000E010
ARRAY_LENGTH		EQU			0x20000780
DIRECTION			EQU			0x20000790
GPIO_PORTF_DATA 	EQU 		0x40025044 ; data a d d r e s s t o a l l pi n s
DATA_PORTA			EQU			0x400043FC	
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	main, READONLY, CODE
			THUMB
			EXTERN		init_lcd
			EXTERN		DELAY100
			EXTERN		init_screen
			EXTERN		WritetoDR
			EXPORT  	__main		; Make available

__main		PROC
			BL			init_lcd
			BL			init_screen
next		b			next			
		
			ENDP*/