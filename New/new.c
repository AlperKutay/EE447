#include "stm32f4xx.h"
#include "cmsis_os2.h"
int main(){
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
	
	GPIOD->MODER |= GPIO_MODER_MODER12_0; // Green LED, set pin 12 as output
	GPIOD->MODER |= GPIO_MODER_MODER13_0; // Orange LED, set pin 13 as output
	GPIOD->MODER |= GPIO_MODER_MODER14_0; // Red LED, set pin 14 as output
	GPIOD->MODER |= GPIO_MODER_MODER15_0; // Blue LED, set pin 15 as output
	while(1){
		GPIOD->BSRR = 1<<12; // Set the BSRR bit X to 1 to turn respective LED on
		
		osDelay(1000U);
			
		GPIOD->BSRR = 1<<28;
			
		osDelay(1000U);
}
}
