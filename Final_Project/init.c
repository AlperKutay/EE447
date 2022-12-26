#include "TM4C123GH6PM.h"
extern void DELAY100();
int main()//PA2: CLK PA3:CE PA4:DIN PA5:DC PA7: RST
{
	SYSCTL->RCGCSSI |= 0x01;
	__NOP();
	__NOP();
	__NOP();
	SYSCTL->RCGCGPIO |= 0x01;
	__NOP();
	__NOP();
	__NOP();
	GPIOA->DIR |= 0xEC;
	GPIOA->DEN |= 0xFC;
	GPIOA->AFSEL |=0x3C;
	GPIOA->PCTL |=0x00222200;
	
	SSI0->CR1 |= 0x00;
	SSI0->CPSR |= 0x04;
	SSI0->CR0 &= ~(0x0030);
	SSI0->CR0 |= 0x07;
	SSI0->CR1 |= 0x02;
	
	
	GPIOA->DATA &= 0x7F;
	DELAY100();
	GPIOA->DATA |= 0x80;
	DELAY100();
	
	
	



}
	