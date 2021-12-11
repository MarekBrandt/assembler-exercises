#include <stdio.h>
void plus_jeden(int** a);
int main()
{
	int m;
	scanf_s("%d", &m);
	int* ptr = &m;
	plus_jeden(&ptr);
	printf("\n m = %d\n", m);
	return 0;
}