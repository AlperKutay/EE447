/* P u l s e i n i t . h f i l e
Function f o r c r e a t i n g a p ul s e t r a i n u si n g i n t e r r u p t s
Uses Channel 0 , and a 1Mhz Timer cl o c k ( TAPR = 1 5 )
Uses Timer0A t o c r e a t e p ul s e t r a i n on PF2
*/
#include "TM4C123GH6PM.h"
void pulse_init ( void ) ;
void TIMER0A_Handler ( void ) ;
#define LOW 0x00000100
#define HIGH 0x00000100
void pulse_init ( void ) 
{
	volatile int *NVIC_EN0 = ( volatile int *) 0xE000E100 ;
	volatile int *NVIC_PRI4 = ( volatile int *) 0xE000E410;
	SYSCTL->RCGCGPIO |= 0x20 ; // tu rn on bus cl o c k f o r GPIOF
	__ASM ( "NOP" ) ;
	__ASM ( "NOP" ) ;
	__ASM ( "NOP" ) ;
	GPIOF->DIR |= 0x04 ; // s e t PF2 a s output
	GPIOF->AFSEL &= ( 0xFFFFFFFB) ; // Regula r p o r t f u n c ti o n
	GPIOF->PCTL &= 0xFFFFF0FF ; // No a l t e r n a t e f u n c ti o n
	GPIOF->AMSEL =0; // Di s a bl e an al o g
	GPIOF->DEN |=0x04 ; // Enable p o r t d i g i t a l
	SYSCTL->RCGCTIMER |=0x01 ; // S t a r t time r 0
	__ASM ( "NOP" ) ;
	__ASM ( "NOP" ) ;
	__ASM ( "NOP" ) ;
	TIMER0->CTL &=0xFFFFFFFE; // Disable timer durin g se tup
	TIMER0->CFG =0x04 ; // Se t 16 b i t mode
	TIMER0->TAMR =0x02 ; // s e t t o p e ri o di c , count down
	TIMER0->TAILR =LOW; // Se t i n t e r v a l l o a d a s LOW
	TIMER0->TAPR =15; // Di vide the cl o c k by 16 t o g e t 1us
	TIMER0->IMR =0x01 ; // Enable time ou t i n t r r u p t
	//Timer0A i s i n t e r r u p t 19
	// I n t e r r u p t 16=19 a r e handled by NVIC r e g i s t e r PRI4
	// I n t e r r u p t 19 i s c o n t r o l l e d by b i t s 3 1: 2 9 o f PRI4
	*NVIC_PRI4 &=0x00FFFFFF ; // Cl e a r i n t e r r u p t 19 p r i o r i t y
	*NVIC_PRI4 |=0x40000000 ; // Se t i n t e r r u p t 19 p r i o r i t y t o 2
	//NVIC has t o be ne abled
	// I n t e r r u p t s 0=31 a r e handled by NVIC r e g i s t e r EN0
	// Interrupt 19 i s c o n t r o l l e d by b i t 19
	*NVIC_EN0 |=0x00080000 ;
	// Enable timer
	TIMER0->CTL |=0x03 ; // bi t 0 t o e n a bl e and b i t 1 t o s t a l l on debug
	return ;
}
void TIMER0A_Handler ( void ) {
	
	
	return ;
}
