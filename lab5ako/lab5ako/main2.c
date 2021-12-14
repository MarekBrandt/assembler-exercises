#include <stdio.h>

float nowy_exp(float x);

int main() {

	float wynik;
	float liczba = 2;
	wynik = nowy_exp(liczba);

	printf("Wynik to : %f", wynik);

	return 0;
}