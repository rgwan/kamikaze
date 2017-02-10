#include <stdio.h>

void tx(char c)
{
	int i;
	volatile int j;
	int ch = (c << 1) + (1 << 9);
	for(i = 0; i < 10; i++) //
	{
		if(ch & (1 << i))
			printf("1");
		else
			printf("0");
	}
}

main()
{
	int i;
	for(i = 0; i < 8; i++)
	{
		tx(1 << i);//
		puts("");
	}
}
