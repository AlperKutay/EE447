#include "TM4C123GH6PM.h"
#include "q1.h"
int main()
{
//run_motor(159999,0);//0 means CCW,1 means CW
	GPIOC_init();
	
	int speed=1599999;
	//run_motor(159999,1);
while(1)
	{
		if(GPIOC->DATA == 0x10)
		{	rotation=1; //CCW Speed increase
			__NOP();
			__NOP();
			__NOP();
			while(GPIOC->DATA == 0x10)
			{
				
			}
			
			if(speed <1600000/8)
			{
				speed=1599999;
				rotation=2;
			}
			speed=speed/2;
			run_motor(speed,rotation);
		}
		else if(GPIOC->DATA == 0x20)//CW Speed increase
		{	rotation=0;
			__NOP();
			__NOP();
			__NOP();
			while(GPIOC->DATA == 0x20)
			{
				
			}
			if(speed =<1600000/8)
			{
				speed=1599999;
				rotation=2;
			}
			speed=speed/2;
			run_motor(speed,rotation);
		}
		
	}
	
}