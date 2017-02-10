#include <stdio.h>
#include <stdint.h>

int main()
{
    FILE *fp, *fp1, *fp2, *fp3, *fp4;
    fp = fopen("firmware.bin", "rb");
    fp1 = fopen("hi.mif", "w+");
    fp2 = fopen("mh.mif", "w+");
    fp3 = fopen("ml.mif", "w+");
    fp4 = fopen("lo.mif", "w+");
    if(!fp)
	{
		printf("File doesn't exist!\n");
		return -1;
	}
	fseek(fp, 0, SEEK_END);
	int size = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	printf("Binary length: %d bytes\n", size);

	uint8_t dat[4];
	int i = 0;
	fprintf(fp1, "DEPTH = 1024;\nWIDTH = 8;\n"
				 "ADDRESS_RADIX = HEX;\n"
				 "DATA_RADIX = HEX;\n"
				 "CONTENT "
				 "BEGIN\n \n");
	fprintf(fp2, "DEPTH = 1024;\nWIDTH = 8;\n"
				 "ADDRESS_RADIX = HEX;\n"
				 "DATA_RADIX = HEX;\n"
				 "CONTENT "
				 "BEGIN\n \n");
	fprintf(fp3, "DEPTH = 1024;\nWIDTH = 8;\n"
				 "ADDRESS_RADIX = HEX;\n"
				 "DATA_RADIX = HEX;\n"
				 "CONTENT "
				 "BEGIN\n \n");
	fprintf(fp4, "DEPTH = 1024;\nWIDTH = 8;\n"
				 "ADDRESS_RADIX = HEX;\n"
				 "DATA_RADIX = HEX;\n"
				 "CONTENT "
				 "BEGIN\n \n");
	while(!feof(fp))
	{
		fread(&dat, 1, 4, fp);
		fprintf(fp1, "%04X : %02X;\n", i, dat[3]);
		fprintf(fp2, "%04X : %02X;\n", i, dat[2]);
		fprintf(fp3, "%04X : %02X;\n", i, dat[1]);
		fprintf(fp4, "%04X : %02X;\n", i, dat[0]);
		i++;
	}
	fprintf(fp1, "\nEND;\n");
	fprintf(fp2, "\nEND;\n");
	fprintf(fp3, "\nEND;\n");
	fprintf(fp4, "\nEND;\n");
	fclose(fp);
	fclose(fp1);
	fclose(fp2);
	fclose(fp3);
	fclose(fp4);
	printf("Done\n");
}
