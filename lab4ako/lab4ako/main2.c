#include <stdio.h>
//int szukaj_max(int a, int b, int c);
int szukaj4_max(int a, int b, int c, int d);
int main()
{
	int x, y, z, d, wynik;
	printf("\nProsz� poda� cztery liczby ca�kowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &d);
	//wynik = szukaj_max(x, y, z);
	wynik = szukaj_max4(x, y, z, d);
	printf("\nSpo�r�d podanych liczb %d, %d, %d, %d, \
 liczba %d jest najwi�ksza\n", x, y, z, d, wynik);
	return 0;
}