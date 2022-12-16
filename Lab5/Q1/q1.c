#include "Init.h"
int main()
{
	init_gpio_adc();
	while(1)
	{
		int data=take_value();
		print_number(data);
	}
}