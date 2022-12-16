#include "Init.h"
int data2,output_data,temp;
int main()
{
	init_gpio_adc();
	while(1)
	{
		int data=take_value()-4095/2;
		if(data<0)
		{
			temp=165*data/2047;
			print_number_with_decimal(temp);
		}
		else 
		{
			temp=165*data/2047;
			print_number_with_decimal(temp);
		}
			
	}
}