#include "TM4C123GH6PM.h"
#include "Init.h"
extern void DELAY100();
extern void init_lcd();
extern void CursorSettings();
extern void init_screen();
extern void WritetoDR();
void SysTick_Handler ( );
void TIMER0A_Handler (void);
extern void printR2Hex_data(int data);
extern void printR2Hex_dete(int data);
extern void printR2Hex_low(int data);
extern void printR2Hex_high(int data);
int main()//PA2: CLK PA3:CE PA5:DIN PA6:DC PA7: RST
{
	init_lcd();
	init_screen();
	init_gpio_adc_ain1();
	init_gpio_adc();
	init_systick();
	init_GPIOB();
	init_LED();
	Timer0_init();
	while(1)
	{
		led_control();
		
	}
}
void SysTick_Handler( )
{
		data_sensor=take_value_sensor()/24;
		data_pot=take_value_pot()/40;
		printR2Hex_data(data_pot);
		DELAY100();
		printR2Hex_dete(data_sensor);

}
void TIMER0A_Handler (void){
	 
	
	if(TIMER0->TAILR==LOW)	
		TIMER0->TAILR=HIGH;
	else											
		TIMER0->TAILR=LOW;
	if(motors==1)
		GPIOB->DATA  = 0x10; //toggle PB4 pin
	else if(motors==2)
		GPIOB->DATA  = 0x20; //toggle PB5 pin
	else if(motors==0)
		GPIOB->DATA  = 0x0; //not working
	TIMER0->ICR |=0x01; 
	return;
}