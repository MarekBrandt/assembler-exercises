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
	mov ebx, 10 ; dzielnik r�wny 10
	mov byte PTR znaki [1], ' '
	mov ecx, eax
	rol ecx, 1
	and ecx, 00000001h
	jz konwersja
	not eax
	inc eax
	mov byte PTR znaki [1], '-'
konwersja:
	mov edx, 0 ; zerowanie starszej cz�ci dzielnej
	div ebx ; dzielenie przez 10, reszta w EDX,
	; iloraz w EAX
	add dl, 30H ; zamiana reszty z dzielenia na kod
	; ASCII
	mov znaki [esi+1], dl; zapisanie cyfry w kodzie ASCII
	dec esi ; zmniejszenie indeksu
	cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype�nienie pozosta�ych bajt�w spacjami i wpisanie
	; znak�w nowego wiersza
	mov edx, esi
wypeln:
	
	or esi, esi
	jz wyswietl ; skok, gdy ESI = 0
	mov byte PTR znaki [esi+1], 20H ; kod spacji
	dec esi ; zmniejszenie indeksu
	jmp wypeln
wyswietl:
	mov ebx, 10
	sub ebx, edx
	mov byte PTR znaki [edx], 0AH ; kod nowego wiersza
	;mov byte PTR znaki [12], 0AH ; kod nowego wiersza
	; wy�wietlenie cyfr na ekranie
	push dword PTR ebx ; liczba wy�wietlanych znak�w
	push dword PTR znaki ; adres wy�w. obszaru
	push dword PTR 1; numer urz�dzenia (ekran ma numer 1)
	call __write ; wy�wietlenie liczby na ekranie
	add esp, 12 ; usuni�cie parametr�w ze stosu
	popa
	ret
wyswietl_EAX ENDP

wyswietl_szereg PROC
	push ebp
	mov ebp, esp
	mov ecx, [ebp+8]
	;mov ecx, OFFSET n
	mov ecx, [ecx]
	dec ecx; liczba obiegow petli
	mov ebx, 0;ktory wyraz w szeregu
	mov eax, 1 ; wartosc elementu
szereg:
	mov edx, ebx ; kopiuje wartosc ecx, by sprawdzic parzystosc
	and edx, 00000001h ; pozostawiam tylko ostatni bit
	jnz nieparzyste
	add eax, ebx
	jmp gotowe
nieparzyste:
	sub eax, ebx
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