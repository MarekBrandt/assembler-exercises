/* Poszukiwanie najwiêkszego elementu w tablicy liczb
 ca³kowitych za pomoca funkcji (podprogramu)
 szukaj64_max, ktora zostala zakodowana w asemblerze.
 Wersja 64-bitowa
*/
#include <stdio.h>
__int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);
int main()
{
	__int64 suma;
	suma = suma_siedmiu_liczb(1,2,3,4,5,6,7);
	printf("\nSuma siedmiu wynosi %I64d\n",
		suma);
	
		return 0;
}