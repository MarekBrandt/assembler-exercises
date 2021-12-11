.686
.model	flat
extern __write : PROC
extern	_ExitProcess@4 : PROC
.data
 znaki db 13 dup (?)
 n dd 30

.code
wyswietl_EAX PROC
	pusha
	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ebx, 10 ; dzielnik równy 10
	mov ecx, eax ; skopiowanie liczby
	rol ecx, 1 ; przesuniecie bitu znaku do lsb
	and ecx, 00000001h ; zamaskowanie bitow poza bitem znaku
	jz konwersja
	not eax ; 
	inc eax ; zamienienie liczby ujemnej w dodatnia(U2)
konwersja:
	mov edx, 0 ; zerowanie starszej czêœci dzielnej
	div ebx ; dzielenie przez 10, reszta w EDX,
	; iloraz w EAX
	add dl, 30H ; zamiana reszty z dzielenia na kod
	; ASCII
	mov znaki [esi+1], dl; zapisanie cyfry w kodzie ASCII
	dec esi ; zmniejszenie indeksu
	cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype³nienie pozosta³ych bajtów spacjami i wpisanie
	; znaków nowego wiersza
	or ecx, ecx ; sprawdzenie czy ecx jest 0
	jz wstaw_endline
	mov znaki [esi+1], '-' ; liczba ujemna, wiec dostawiam -
	dec esi ; zmniejszam indeks znakow
wstaw_endline:
	;mov znaki[esi], 20h
	mov znaki [esi+1], 0ah ; wstawiam znak konca linii
	dec esi
	mov edx, esi ; zapisuje w edx indeks ostatniego znaku, (potrzebny do wyliczenia liczby wstawionych znakow)
wypeln:
	or esi, esi
	jz wyswietl ; skok, gdy ESI = 0
	mov byte PTR znaki [esi+1], 20H ; kod spacji
	dec esi ; zmniejszenie indeksu
	jmp wypeln
wyswietl:
	mov ebx, 10 ; wstawienie poczatkowego indeksu w tablicy
	sub ebx, edx ; obliczenie l. znakow -1
	inc ebx ; liczba znakow
	inc edx ; wracam na znak konca linii
	mov eax, OFFSET znaki ; przepisuje adres tablicy znakii
	add edx, eax ; dodaje indeks pocz¹tkowy znaku od adresu tablicy
	
	; wyœwietlenie cyfr na ekranie
	push dword PTR ebx ; liczba wyœwietlanych znaków
	push dword PTR edx ; adres wyœw. obszaru
	push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
	call __write ; wyœwietlenie liczby na ekranie
	add esp, 12 ; usuniêcie parametrów ze stosu
	popa
	ret
wyswietl_EAX ENDP

wyswietl_szereg PROC
	push ebp
	mov ebp, esp
	mov ecx, [ebp+8]
	mov ecx, [ecx]
	dec ecx; liczba obiegow petli
	mov ebx, 0 ;ktory wyraz w szeregu
	mov eax, 1 ; wartosc elementu
szereg:
	mov edx, ebx ; kopiuje wartosc ecx, by sprawdzic parzystosc
	and edx, 00000001h ; pozostawiam tylko ostatni bit
	jnz nieparzyste
	add eax, ebx ; parzyste wiec dodaje
	jmp gotowe
nieparzyste:
	sub eax, ebx ; nieparzyste wiec odejmuje
gotowe:
	call wyswietl_EAX
	inc ebx
	dec ecx
	jnz szereg
	pop ebp
	ret 4
wyswietl_szereg ENDP

_main PROC
	push OFFSET n
	call wyswietl_szereg
	
	push 0
	call _ExitProcess@4
_main ENDP
END