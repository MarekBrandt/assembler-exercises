#include <stdio.h>

extern int funkcja(int x);

int main() {

	int a;
	int b = 4;
	a = funkcja(b);
	printf("Liczba: %d", a);

	return 0;
}