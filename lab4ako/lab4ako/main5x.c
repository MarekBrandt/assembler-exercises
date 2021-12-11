#include <stdio.h>

unsigned int check_system_dir(char* directory);

int main() {
	unsigned int wynik;
	char* znaki = "C:\\WINDOWS\\system32";

	wynik = check_system_dir(znaki);
	printf("\nWynik = %d\n", wynik);

	return 0;
}