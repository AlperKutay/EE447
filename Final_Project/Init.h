#include "TM4C123GH6PM.h"
#define LOW 	60
#define HIGH 	15

extern void OutStr(char*);
int value_sensor,value_pot;
char msg1[100],msg2[100];
int data_sensor,data_pot,motors;
int new_number,data_256_sensor[256],index=0;
void print_number(int number);
void init_gpio_adc();
int take_value_sensor();
int take_average(int *data);
void init_gpio_adc_ain1();
int take_value_pot();
void init_systick();
void TIMER0A_Handler (void);
void Timer0_init(void);
void init_LED();
void init_GPIOB();
int led_control();
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
	ADC0->EMUX &= ~0xF000;
	ADC0->SSMUX3 |=0x0000;
	ADC0->SSCTL3 |=0x06;
	ADC0->PC |=0x01;

}
void init_gpio_adc_ain1()
{
	SYSCTL->RCGCADC |= 0x2;
	__NOP();
	__NOP();
	__NOP();
	SYSCTL->RCGCGPIO |= 0x10;
	__NOP();
	__NOP();
	__NOP();
	GPIOE->AFSEL |=0x04;
	//GPIOE->DIR |= 0x04;
	GPIOE->DEN |= 0x04;
	GPIOE->AMSEL |= 0x04;
	
	ADC1->ACTSS &= ~0x04;
	ADC1->EMUX &= ~0x0F00;
	ADC1->SSMUX2 |=0x0001;
	ADC1->SSCTL2 |=0x06;
	ADC1->PC |=0x01;
	ADC1->ACTSS |= 0x04;

}
void init_systick()
{
	SysTick->LOAD = 15999999; 
	SysTick->VAL = 0; 
	SysTick->CTRL = 0x07 ; 

}
int take_value_sensor()
{
	int average;
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
			value_sensor=ADC0->SSFIFO3;
			data_256_sensor[index]=value_sensor;
			index++;
			if(index==256)
			{
				index=0;
				average=take_average(data_256_sensor);
				ADC0->ISC |= 0x08;
				return(average);
			}
				
			
	}
	
}
int take_value_pot()
{
	
	while(1)
	{
			ADC1->PSSI |= 0x04;
			while(1)
			{
				if(ADC1->RIS & 0x04)
				{
					break;
				}
			}
			value_pot=ADC1->SSFIFO2;
			ADC1->ISC |= 0x04;
			return(value_pot);
		}
	
}
int take_average(int *data)
{
	int sum=0;
	for(int i=0;i<256;i++)
	{
		sum+=data[i];
	}
	return sum/256;
}
void init_LED()
{
	SYSCTL->RCGCGPIO |= 0x20; // turn on bus clock for GPIOF
	__ASM("NOP");
	__ASM("NOP");
	__ASM("NOP");
	GPIOF->DIR			|= 0x0E; //set PF2 as output
  GPIOF->AFSEL		&= (0xFFFFFFF1);  // Regular port function
	GPIOF->PCTL			&= 0xFFFF000F;  // No alternate function
	GPIOF->AMSEL		=0; //Disable analog
	GPIOF->DEN			|=0x0E; // Enable port digital
	
}
void init_GPIOB()
{
	SYSCTL->RCGCGPIO |= 0x02; // turn on bus clock for GPIOB
	__ASM("NOP");
	__ASM("NOP");
	__ASM("NOP");
	GPIOB->DIR			|= 0x30; //set PB2 and PB1 as output
  //GPIOB->AFSEL		&= (0xFFFFFFF3);  // Regular port function
	//GPIOB->PCTL			&= 0xFFFF00FF;  // No alternate function
	GPIOB->AMSEL		=0; //Disable analog
	GPIOB->DEN			|=0x30; // Enable port digital
	
}
void Timer0_init(void){
	volatile int *NVIC_EN0 = (volatile int*) 0xE000E100;
	volatile int *NVIC_PRI4 = (volatile int*) 0xE000E410;
	
	
	//GPIOF->DIR       |= 0x08; //set GREEN pin as a digital output pin
  //GPIOF->DEN       |= 0x08;  // Enable PF3 pin as a digital pin
	
	SYSCTL->RCGCTIMER	|=0x01; // Start timer0
	__ASM("NOP");
	__ASM("NOP");
	__ASM("NOP");
	TIMER0->CTL			&=0xFFFFFFFE; //Disable timer during setup
	TIMER0->CFG			=0x04;  //Set 16 bit mode
	TIMER0->TAMR		=0x02; // set to periodic, count down
	TIMER0->TAILR		=LOW; //Set interval load as LOW
	TIMER0->TAPR		=15; // Divide the clock by 16 to get 1us
	TIMER0->IMR			=0x01; //Enable timeout intrrupt	
	
	//Timer0A is interrupt 19
	//Interrupt 16-19 are handled by NVIC register PRI4
	//Interrupt 19 is controlled by bits 31:29 of PRI4
	*NVIC_PRI4 &=0x00FFFFFF; //Clear interrupt 19 priority
	*NVIC_PRI4 |=0x40000000; //Set interrupt 19 priority to 2
	
	//NVIC has to be neabled
	//Interrupts 0-31 are handled by NVIC register EN0
	//Interrupt 19 is controlled by bit 19
	*NVIC_EN0 |=0x00080000;
	
	//Enable timer
	TIMER0->CTL			 |=0x03; // bit0 to enable and bit 1 to stall on debug
	return;
}

int led_control()
{
	if(data_sensor>data_pot+3)//Blue
	{
		GPIOF->DATA = 0x04;
		motors=1;
	}
	else if(data_sensor<(data_pot+3) && data_sensor>(data_pot-3))//Green 
	{
		GPIOF->DATA = 0x08;
		motors=0;
	}
	else if(data_sensor<data_pot-3)//Red 
	{
		GPIOF->DATA = 0x02;
		motors=2;
	}
	return(motors);
}