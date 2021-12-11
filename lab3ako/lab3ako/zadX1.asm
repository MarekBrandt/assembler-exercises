.686
.model	flat
extern __write : PROC
extern	_ExitProcess@4 : PROC
.data
 znaki db 12 dup (?)
 liczba dd 11b

.code
wyswietl_spod_adresu_EBX PROC
	pusha
	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ecx, 10 ; dzielnik r�wny 10
	or ebx, ebx
	jnz dalej
	push 0
	call _ExitProcess@4
dalej:
	mov eax, [ebx]
konwersja:
	mov edx, 0 ; zerowanie starszej cz�ci dzielnej
	div ecx ; dzielenie przez 10, reszta w EDX,
	; iloraz w EAX
	add dl, 30H ; zamiana reszty z dzielenia na kod
	; ASCII
	mov znaki [esi], dl; zapisanie cyfry w kodzie ASCII
	dec esi ; zmniejszenie indeksu
	cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype�nienie pozosta�ych bajt�w spacjami i wpisanie
	; znak�w nowego wiersza
wypeln:
	or esi, esi
	jz wyswietl ; skok, gdy ESI = 0
	mov byte PTR znaki [esi], 20H ; kod spacji
	dec esi ; zmniejszenie indeksu
	jmp wypeln
wyswietl:
	mov byte PTR znaki [0], 0AH ; kod nowego wiersza
	mov byte PTR znaki [11], 0AH ; kod nowego wiersza
	; wy�wietlenie cyfr na ekranie
	push dword PTR 12 ; liczba wy�wietlanych znak�w
	push dword PTR OFFSET znaki ; adres wy�w. obszaru
	push dword PTR 1; numer urz�dzenia (ekran ma numer 1)
	call __write ; wy�wietlenie liczby na ekranie
	add esp, 12 ; usuni�cie parametr�w ze stosu
	popa
	ret
wyswietl_spod_adresu_EBX ENDP

_main PROC
	mov ebx, OFFSET liczba
	call wyswietl_spod_adresu_EBX	
	push 0
	call _ExitProcess@4
_main ENDP
END