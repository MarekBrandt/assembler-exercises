#include <stdio.h>

int* szukaj_elem_max(int tablica[], int n);

int main() {
	int pomiary[7] = {1,2,3,4,5,6,7}, * wsk;
	wsk = szukaj_elem_max(pomiary, 7);
	printf("\nElement maksymalny = %d\n", *wsk);
	
	return 0;
}