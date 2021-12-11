; wczytywanie i wyœwietlanie tekstu wielkimi literami
; (inne znaki siê nie zmieniaj¹)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
public _main
.data
tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
liczba_znakow dd ?
.code
_main PROC
; wyœwietlenie tekstu informacyjnego
; liczba znaków tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urz¹dzenia (tu: ekran - nr 1)
 call __write ; wyœwietlenie tekstu pocz¹tkowego
 add esp, 12 ; usuniecie parametrów ze stosu
; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znaków
 push OFFSET magazyn
 push 0 ; nr urz¹dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; usuniecie parametrów ze stosu
; kody ASCII napisanego tekstu zosta³y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbê
; wprowadzonych znaków
 mov liczba_znakow, eax
; rejestr ECX pe³ni rolê licznika obiegów pêtli
 mov ecx, eax
 dec ecx ; zmniejszam licznik petli o 1, bo pomijam ostatni znak
 sub eax, 2 ; ustawiam indeks na ostatni znak, pomijam null
 mov ebx, eax; indeks pocz¹tkowy
 mov eax, 0 ;liczba znakow w slowie
ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znaku 
 cmp dl, ' '
 je dalej
 push edx
 dec ebx ; inkrementacja indeksu
 inc eax ; kolejny znak w slowie
 loop ptl ; sterowanie pêtl¹
 jmp dalej2

dalej:
 push eax
 mov eax,0 ; zeruje licznik liter w slowie
 dec ebx ; nastepna litera
 dec ecx
 jmp ptl

 dalej2:
 push eax ; wstawia ostatnia liczbe znakow
 mov eax, 0 ; eax bedzie sie zwiekszal z kazdym wstawionym znakiem
 mov edi, 3; liczba wykonan petli 3
 ptl3:
 mov ebx, liczba_znakow 
 dec ebx ; pomijam nulla
 pop ecx ; bierze liczbe liter slowa
 sub ebx, eax ; odejmuje juz wstawione znaki
 sub ebx, ecx ; ustawia indeks poczatkowy
 jz dalej3
 mov magazyn[ebx-1], ' '
 inc eax
 dalej3:
 ;mov magazyn[ebx-1], ' ' ; wstawia spacje przed slowem
 ;inc eax
 ptl2: 
 pop edx
 mov magazyn[ebx], dl ; wstawia litere zdjeta ze stosu do magazynu
 inc eax
 inc ebx
 loop ptl2
 dec edi
 jnz ptl3


; wyœwietlenie przekszta³conego tekstu
 push liczba_znakow
 push OFFSET magazyn
 push 1
 call __write ; wyœwietlenie przekszta³conego tekstu
 add esp, 12 ; usuniecie parametrów ze stosu
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END
