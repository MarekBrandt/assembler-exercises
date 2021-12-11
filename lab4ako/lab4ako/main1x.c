#include <stdio.h>
#include <Windows.h>
extern unsigned short dajMinuty(SYSTEMTIME * st);

int main() {
	unsigned short minuty;
	SYSTEMTIME st;
	minuty = dajMinuty(&st);
	printf("Minuta: %d\n", minuty);

	return 0;
}