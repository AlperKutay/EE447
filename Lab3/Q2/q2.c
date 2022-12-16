#include "TM4C123GH6PM.h"
#include "q1.h"
int main()
{
//run_motor(159999,0);//0 means CCW,1 means CW
	GPIOC_init();
	int dummy_index=0,speed=159999;
	//run_motor(159999,1);
	init_function(speed);
while(1)
	{
		if(GPIOC->DATA == 0x10)
		{	
			GPIOB->DATA=GPIOB->DATA >> 1;
			while(GPIOC->DATA == 0x10)
			{
				
			}
			GPIOB->DATA=GPIOB->DATA << 1;
		}
		else if(GPIOC->DATA == 0x20)
		{	
			GPIOB->DATA=GPIOB->DATA << 1;
			while(GPIOC->DATA == 0x20)
			{
				
			}
			GPIOB->DATA=GPIOB->DATA >> 1;
		}
		
	}
	
}