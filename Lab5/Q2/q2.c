#include "Init.h"
int main()
{
	init_gpio_adc();
	while(1)
	{
		int data=take_value();
		if(data<4095/2)
			print_number(4095/2);
		else
			print_number(data);
	}
}