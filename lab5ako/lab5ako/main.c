#include <stdio.h>

float srednia_harm(float* tablica, unsigned int n);

int main() {

	float wynik;
	float tablica[] = { 1.2f, 3.1f };
	unsigned int n = 2;
	wynik = srednia_harm(tablica, n);

	printf("Wynik to : %f", wynik);

	return 0;
}