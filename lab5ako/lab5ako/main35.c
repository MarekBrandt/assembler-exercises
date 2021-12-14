/* Program przyk³adowy ilustruj¹cy operacje SSE procesora
 Program jest przystosowany do wspó³pracy z podprogramem
 zakodowanym w asemblerze (plik arytm_SSE.asm)
*/
#include <stdio.h>
void dodaj_SSE(char*, char*, char*);
int main()
{
	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	char liczby_C[16];
	dodaj_SSE(liczby_A, liczby_B, liczby_C);
	printf("\n%i %i %i %i", liczby_A[0], liczby_A[1], liczby_A[2], liczby_A[3] );
	printf("\n%i %i %i %i", liczby_B[0], liczby_B[1], liczby_B[2], liczby_B[3]);
	printf("\n%i %i %i %i", liczby_C[0], liczby_C[1], liczby_C[2], liczby_C[3]);
	
	return 0;
}
