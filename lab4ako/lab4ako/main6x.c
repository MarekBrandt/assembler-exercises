#include <stdio.h>

int dzielenie(int* dzielna, int** dzielnik);

int main() {
	int a, b, * wsk;
	int wynik;

	wsk = &b;

	a = -4; b = -2;

	wynik = dzielenie(a, &wsk);
	printf("\nWynik = %d\n", wynik);

	return 0;
}