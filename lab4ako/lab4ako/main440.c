#include <stdio.h>
void przestaw(int tabl[], int n);
int main()
{
	int tab[] = { 8,5,2,1 };
	int size = sizeof(tab) / sizeof(int);
	for (int i = size; i > 1; i--) {
		przestaw(tab, i);
	}
	//przestaw(tab, size);
	for (int i = 0; i < size; i++) {
		printf("%d ", tab[i]);
	}
	printf("\n");
	return 0;
}