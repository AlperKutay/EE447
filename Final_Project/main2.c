#include "TM4C123GH6PM.h"
#include "Init.h"
void TIMER0A_Handler (void);
int main()//PA2: CLK PA3:CE PA5:DIN PA6:DC PA7: RST
{
	init_GPIOB();	
	Timer0_init();
	while(1)
	{
	}
}
void TIMER0A_Handler (void){
	 
	
	if(TIMER0->TAILR==LOW)	
		TIMER0->TAILR=HIGH;
	else											
		TIMER0->TAILR=LOW;
	GPIOB->DATA  ^= 6; //toggle PB3 pin
	TIMER0->ICR |=0x01; 
	return;
}