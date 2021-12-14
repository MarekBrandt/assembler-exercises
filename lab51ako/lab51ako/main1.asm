.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main
.data
znaki db 13 dup (?)
x dq +0.1
krok dq +0.1
float dd ?
float_c dd ?
float_u dd ?
tysiac dd +1000.0
trybPracy dw 0f7fh
.code
wyswietl_EAX PROC
	pusha
	
	finit
	fldcw word ptr trybPracy
	fld dword ptr float
	frndint	
	fist dword ptr float_c ; wpisanie czesci calk do pamieci
	finit
	fild dword ptr float_c
	fld dword ptr float
	fsub st(0), st(1)
	fmul dword ptr tysiac
	
	fist dword ptr float_u

	mov eax, dword ptr float_u
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
	mov eax, dword ptr float_c
	cmp eax, 0
	je dalej
	mov edx, 0
	mov dl, '.'
	mov znaki[esi+1], dl
	dec esi
	mov dword ptr float_c, 0
	jmp konwersja
	dalej:
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

_main PROC
	mov ecx, 5
	ptl:
	finit
		fld qword ptr x
		fldl2e ; log 2 e
		fmulp st(1), st(0) ; obliczenie x * log 2 e
		; kopiowanie obliczonej wartoœci do ST(1)
		fst st(1)

		; zaokr¹glenie do wartoœci ca³kowitej
		frndint
		fsub st(1), st(0) ; obliczenie czêœci u³amkowej
		fxch ; zamiana ST(0) i ST(1)
		; po zamianie: ST(0) - czêœæ u³amkowa, ST(1) - czêœæ ca³kowita
		; obliczenie wartoœci funkcji wyk³adniczej dla czêœci
		; u³amkowej wyk³adnika
		f2xm1
		fld1 ; liczba 1
		faddp st(1), st(0) ; dodanie 1 do wyniku
		; mno¿enie przez 2^(czêœæ ca³kowita)
		fscale
		; przes³anie wyniku do ST(1) i usuniêcie wartoœci
		; z wierzcho³ka stosu
		fstp st(1)
		; w rezultacie wynik znajduje siê w ST(0)

		fst dword ptr float
		call wyswietl_EAX	

		fld qword ptr x
		fld qword ptr krok
		fadd st(0), st(1)
		fstp qword ptr x

		loop ptl


	push 0
	call _ExitProcess@4 
_main ENDP

END