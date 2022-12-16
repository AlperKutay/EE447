#include "Init.h"
int data2,output_data,temp;
int main()
{
	init_gpio_adc();
	systick_init();
	while(1)
	{
		
			
	}
}
void SysTick_Handler ( void )
{
	int data=take_value();
	temp=165*data/2047;
	print_number_with_decimal(temp);
}