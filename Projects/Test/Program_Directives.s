;*************************************************************** 
; Program_Directives.s  
; Copies the table from one location
; to another memory location.           
; Directives and Addressing modes are   
; explained with this program.   
;***************************************************************    
;*************************************************************** 
; EQU Directives
; These directives do not allocate memory
;***************************************************************
;LABEL      DIRECTIVE   VALUE       COMMENT
OFFSET      EQU         0x22
FIRST       EQU         0x20000700  
;***************************************************************
; Directives - This Data Section is part of the code
; It is in the read only section  so values cannot be changed.
;***************************************************************
;LABEL      DIRECTIVE   VALUE       COMMENT
            AREA        sdata, DATA, READONLY
            THUMB
CTR1        DCB         0x11
MSG         DCB         "Copying table..."
            DCB         0x0D
            DCB         0x04
;***************************************************************
; Program section                         
;***************************************************************
;LABEL      DIRECTIVE   VALUE       COMMENT
            AREA        main, READONLY, CODE
            THUMB
            EXPORT      __main      ; Make available

__main
start       LDR 		R0, =0x20000040;Set the operand’s address to R0
			LDRB 		R1, [R0];Load the byte at the address R0
			BFC 		R1, #4, #4;Clear bits from 4 to 7 of R1
			STRB 		R1, [R0, #4];Store the byte to R0+4
			LDRB 		R1, [R0];Load the byte at the address R0
			LSR 		R1, R1, #4;Shift the four MSB to LSB position
			STRB 		R1, [R0, #5];Store the byte to R0+5
			B 			start
Done 		B 			Done;Loop at this instruction
;***************************************************************
; End of the program  section
;***************************************************************
;LABEL      DIRECTIVE       VALUE                           COMMENT
            ALIGN
            END
