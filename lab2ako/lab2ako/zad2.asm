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
magazyn1 db 80 dup (?)
magazyn2 db 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?
liczba_z1 dd ?
liczba_z2 dd ?
liczba_z3 dd ?
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
 mov ebx, 0 ; indeks pocz¹tkowy
ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znaku 
 cmp dl, ' '
 je dalej
 mov magazyn1[ebx], dl
 inc ebx ; inkrementacja indeksu
 loop ptl ; sterowanie pêtl¹

dalej:
mov liczba_z1, ebx
inc ebx
mov eax, 0

ptl2: mov dl, magazyn[ebx]
 cmp dl, ' '
 je dalej2
 mov magazyn2[eax], dl
 inc ebx
 inc eax
 loop	ptl2
dalej2:
dec ebx
mov liczba_z2, ebx
sub liczba_z2, eax
 add ebx, 2
 mov eax, 0

 ptl3: mov dl, magazyn[ebx]
 mov magazyn[eax], dl
 inc ebx
 inc eax
 loop ptl3
 sub eax, 3
 mov liczba_z3, eax
 mov magazyn[eax], ' '

 mov ecx, liczba_z2
 mov eax, 0
 mov ebx, liczba_z3
 inc ebx
ptl4: mov dl, magazyn2[eax]
mov magazyn[ebx], dl





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
