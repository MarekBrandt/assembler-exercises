#include <stdio.h>
#include <xmmintrin.h>

void dziel(__m128* tablica1, unsigned  int  n, float dzielnik);

void main()
{
    double tab[] = { 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f };
    __m128 tablica[3] = { (__m128) { tab[0], tab[1] },
                          (__m128) {
tab[2], tab[3]
},
(__m128) {
tab[4], tab[5]
} };

    dziel(tablica, 3, 2.0);
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++)
        {
            printf("%d,%d = %f\n", i, j, tablica[i].m128_f32[j]);
        }
}