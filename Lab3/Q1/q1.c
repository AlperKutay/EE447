#include "TM4C123GH6PM.h"

void init_function(int speed);
void SysTick_Handler ( void );
void run_motor(int speed,int rot);
int a=0,rotation;
void GPIOC_init(void);
void init_function(int speed){
		
	SYSCTL->RCGCGPIO |= 0x2 ; // tu rn on bus cl o c k f o r GPIOF
	GPIOB->DIR |= 0x0F ; // s e t GREEN pin a s a d i g i t a l output pin
	GPIOB->DEN |= 0xFF ; // Enable PF3 pin a s a d i g i t a l pin
		
	SysTick->LOAD = speed; // C o n fi g u r e l o a d v al u e
	SysTick->VAL = 0; // Cl e a r the tim e r r e g i s t e r by w ri ti n g t o i 
	SysTick->CTRL = 0x07 ; // s o u r c e system bus , i n t e r r u p t en abled and cl o c k i s s t a r t e d
	GPIOB->DATA ^=1;
}
void GPIOC_init(void){
		
	SYSCTL->RCGCGPIO |= 0x4 ; // tu rn on bus cl o c k f o r GPIOF
	GPIOC->DIR |= 0x0F ; // s e t GREEN pin a s a d i g i t a l output pin
	GPIOC->DEN |= 0xFF ; // Enable PF3 pin a s a d i g i t a l pin
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
}
void run_motor(int speed,int rot)
{
	rotation=rot;
	init_function(speed);
}
int main()
{
	run_motor(159999,1);//0 means CCW,1 means CW
	while(1)
	{
		a++;
	}
		
}