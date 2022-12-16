extern char InChar(void); 
extern void OutChar(char); 

int main(void){
	/* allocate memory for data                            */
	/* C compiler places the array in a suitable location. */

	while(1){
		char input;
		input=InChar();
		OutChar(InChar());
	
	}
}

