#include "Pulse_init.h"
#include "TM4C123GH6PM.h"
#include <stdio.h>

extern void OutStr(char*);
void print_number(int number);
int x,edge=0;
int edge1,edge2,edge3;
int period,pulse_width,duty_cycle,new_number;
char msg1[100],msg2[100];

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
	int main(){
		pulse_init();
		detect_init();
		while(1){

			x=TIMER1->RIS&4;	//Seperating CAERIS bit
			if(x==4){				
				if(edge==0)
				{
					edge1=TIMER1->TAR;	//Get timer register value
					edge=edge+1;
					TIMER1->ICR |=0x04;//Clear ICR
					continue;					
				}
				else if(edge==1)
				{
					edge2=TIMER1->TAR;	//Get timer register value
					edge=edge+1;		
					TIMER1->ICR |=0x04;//Clear ICR
					continue;
				}
				else if(edge==2)
				{
					edge3=TIMER1->TAR;//Get timer register value
					edge=edge+1;		
					TIMER1->ICR |=0x04; //Clear ICR
					continue;
				}
				else
				{
					period=edge1-edge3; //PERIOD (FIRST EDGE - THIRD EDGE) [IN CYCLE UNIT, NOT IN ns]
					pulse_width=edge1-edge2;//PULSE WIDTH (FIRST EDGE- SECOND EDGE) [IN CYCLE UNIT, NOT IN ns]
					duty_cycle=(pulse_width*100)/period; //Pulse Width*100 / PERIOD = DUTY CYCLE
					OutStr("Duty Cycle (%): \r\4");
					print_number(duty_cycle);
					OutStr("Pulse Width (us): \r\4");
					print_number(pulse_width/16);
					OutStr("Period (us): \r\4");
					print_number(period/16);
				}
						while(1){}
					
				}

			}
				
}