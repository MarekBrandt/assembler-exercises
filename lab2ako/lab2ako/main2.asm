; wczytywanie i wyœwietlanie tekstu wielkimi literami
; (inne znaki siê nie zmieniaj¹)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
public _main
.data
tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?
tytul db 'tytul',0
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
 cmp dl, 0A5H
 je maleA
 cmp dl, 86H
 je maleC
 cmp dl, 0A9H
 je maleE
 cmp dl, 88H
 je maleL
 cmp dl, 0e4H
 je maleN
 cmp dl, 0a2h
 je maleO
 cmp dl, 98h
 je maleS
 cmp dl, 0abh
 je maleZ
 cmp dl, 0beh
 je maleZZ
 ;cmp dl, 
 cmp dl, 'a'
 jb dalej ; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej ; skok, gdy znak nie wymaga zamiany
 sub dl, 20H ; zamiana na wielkie litery
 jmp dalej2

 maleA: mov dl, 0A4H
 jmp dalej2
 maleC: mov dl, 08FH
 jmp dalej2
 maleE: mov dl, 0A8H
 jmp dalej2
 maleL: mov dl, 9DH
 jmp dalej2
 maleN: mov dl, 0E3H
 jmp dalej2
 maleO: mov dl, 0E0H
 jmp dalej2
 maleS: mov dl, 97H
 jmp dalej2
 maleZ: mov dl, 8DH
 jmp dalej2
 maleZZ: mov dl, 0AFH
 jmp dalej2

 dalej2: mov magazyn[ebx], dl
dalej: inc ebx ; inkrementacja indeksu
 dec ecx ; sterowanie pêtl¹
 jnz ptl
; wyœwietlenie przekszta³conego tekstu
 push liczba_znakow
 push OFFSET magazyn
 push 1
 call __write ; wyœwietlenie przekszta³conego tekstu
 add esp, 12 ; usuniecie parametrów ze stosu
 push 0
 push OFFSET tytul
 push OFFSET magazyn
 push 0
 call _MessageBoxA@16
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END
