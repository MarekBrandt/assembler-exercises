/* Program przyk³adowy ilustruj¹cy operacje SSE procesora
 Program jest przystosowany do wspó³pracy z podprogramem
 zakodowanym w asemblerze (plik arytm_SSE.asm)
*/
#include <stdio.h>
float oblicz_potege(unsigned char k, int m);
int main()
{
	float wf; int i;

	for (i = -7; i < 7; i++)

	{

		wf = oblicz_potege(24, i);

		printf("\ni = %d    wf = %10.2f", i, wf);

	}
	
	return 0;
}
