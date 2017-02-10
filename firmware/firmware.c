#define GPIO_A_ODR (*(volatile char*)0x10000000)
void putc(char c)
{
	int i;
	volatile int j;
	int ch = (c << 1) + (1 << 9);
	for(i = 0; i < 10; i++) //
	{
		if(ch & (1 << i))
			GPIO_A_ODR = 0x03;
		else
			GPIO_A_ODR = 0x00;
		for(j = 0; j < 9; j++)
			__asm__("nop");
			
	}
}

void puts(const char *s)
{
	volatile int j;
	while (*s)
	{
		putc(*s++);
		int j;
		for(j = 0; j < 1000; j++)
			__asm__("nop");
	}
}


void *memcpy(void *dest, const void *src, int n)
{
	while (n) 
	{
		n--;
		((char*)dest)[n] = ((char*)src)[n];
	}
	return dest;
}

void main()
{
	char message[] = "$Uryyb+Jbeyq!+Vs+lbh+pna+ernq+guvf+zrffntr+gura$gur+CvpbEI32+PCH"
			"+frrzf+gb+or+jbexvat+whfg+svar.$$++++++++++++++++GRFG+CNFFRQ!$$";
	for (int i = 0; message[i]; i++)
		switch (message[i])
		{
		case 'a' ... 'm':
		case 'A' ... 'M':
			message[i] += 13;
			break;
		case 'n' ... 'z':
		case 'N' ... 'Z':
			message[i] -= 13;
			break;
		case '$':
			message[i] = '\n';
			break;
		case '+':
			message[i] = ' ';
			break;
		}
	while(1)
	{
		/*putc(0x55);
		putc(0xaa);*/
		puts(message);
		
	}
}

