#include "TM4C123GH6PM.h"
extern void OutStr(char*);
int value1,value2;
char msg1[100],msg2[100];
int new_number;
void print_number(int number);
void init_gpio_adc();
int take_value();
void print_number(int number)
{	
		int i=0,j=0;
		while(number){
			new_number=number/10;
			msg1[i]=number-(new_number*10)+48;	
			number=new_number;
			i++;								
		}
		for(i=i-1;i>=0;i--){	
		msg2[j]=msg1[i];	
		j++;
		}
		
		msg2[j]='\r';		
		msg2[j+1]='\4';	
		OutStr(msg2);
}
void init_gpio_adc()
{
	SYSCTL->RCGCADC |= 0x1;
	value1= SYSCTL->PRADC;
	__NOP();
	__NOP();
	__NOP();
	SYSCTL->RCGCGPIO |= 0x10;
	__NOP();
	__NOP();
	__NOP();
	GPIOE->AFSEL |=0x08;
	GPIOE->DEN |= 0x08;
	GPIOE->AMSEL |= 0x08;
	//GPIOE->DIR |= ~0x08;
	ADC0->ACTSS |= 0x08;
	ADC0->EMUX |= ~0xF000;
	ADC0->SSMUX3 |=0x0000;
	ADC0->SSCTL3 |=0x06;
	ADC0->PC |=0x01;
	ADC0->ACTSS |=0x08;

}
int take_value()
{
	while(1)
	{
			ADC0->PSSI |= 0x08;
			while(1)
			{
				if(ADC0->RIS & 0x08)
				{
					break;
				}
			}
			value2=ADC0->SSFIFO3;
			ADC0->ISC |= 0x08;
			return(value2);
	}
}