#include "TM4C123GH6PM.h"

void init_function(int speed);
void SysTick_Handler ( void );
void run_motor(int speed,int rot);
int a=0,rotation;
void GPIOC_init(void);
void init_function(int speed){
		
	SYSCTL->RCGCGPIO |= 0x2 ; // turn on bus clock for GPIOB
	GPIOB->DIR |= 0x0F ; // Set PB0-1-2-3 as output pin
	GPIOB->DEN |= 0xFF ; // Enable PB0-1-2-3 pin as a digital pin
		
	SysTick->LOAD = speed; // Configure load value
	SysTick->VAL = 0; // Clear the timer register by writingt oi 
	SysTick->CTRL = 0x07 ; // source system bus , interrupt enabled and clockisstarted
	GPIOB->DATA ^=1;
}
void GPIOC_init(void){
		
	SYSCTL->RCGCGPIO |= 0x4 ; // turn on bus clock for GPIOC
	GPIOC->DIR |= 0xCF ; // Set PC4-5-6-7 as input pin
	GPIOC->DEN |= 0xFF ; // // Enable PC4-5-6-7 pin as a digital pin
	GPIOC->DATA &= 0x0;
}
//volatile int * GPIOB_DATA = (volatile int*) 0x4000503C;
void SysTick_Handler ( void )
{
	if(rotation==0)//CCW
	{
		GPIOB->DATA=GPIOB->DATA>>1;
		if(GPIOB->DATA == 0)
		{	
			GPIOB->DATA ^=8;
		}
	}
	else if(rotation==1)//CW
	{
		GPIOB->DATA=GPIOB->DATA<<1;
		if(GPIOB->DATA == 8)
		{	
			GPIOB->DATA ^=1;
		}	
	}
	else if(rotation==2)
	{
		GPIOB->DATA =0;
		a++;//dummy index
	}
}
void run_motor(int speed,int rot)
{
	rotation=rot;
	init_function(speed);
}
