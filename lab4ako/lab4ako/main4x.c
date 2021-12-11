#include <stdio.h>

int odejmowanie(int** odjemna, int* odjemnik);

int main() {
	int a, b, * wsk, wynik;

	wsk = &a;

	a = 21; b = 25;

	wynik = odejmowanie(&wsk, &b);
	printf("\nWynik = %d\n", wynik);

	return 0;
}