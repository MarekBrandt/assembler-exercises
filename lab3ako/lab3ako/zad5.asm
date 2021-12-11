.686
.model	flat
extern __read : PROC
extern __write : PROC
extern	_ExitProcess@4 : PROC
.data
 znaki db 12 dup (?)
 dziesiec dd 10 ; mnoznik
 dekoder db '0123456789ABCDEF'

.code
wczytaj_do_EAX PROC
	push ebx
	push ecx
		; max iloœæ znaków wczytywanej liczby
	push dword PTR 12
	push dword PTR OFFSET znaki ; adres obszaru pamiêci
	push dword PTR 0; numer urz¹dzenia (0 dla klawiatury)
	call __read ; odczytywanie znaków z klawiatury
	; (dwa znaki podkreœlenia przed read)
	add esp, 12 ; usuniêcie parametrów ze stosu
	; bie¿¹ca wartoœæ przekszta³canej liczby przechowywana jest
	; w rejestrze EAX; przyjmujemy 0 jako wartoœæ pocz¹tkow¹
	mov eax, 0
	mov ebx, OFFSET znaki ; adres obszaru ze znakami
	pobieraj_znaki:
	mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie
	; ASCII
	inc ebx ; zwiêkszenie indeksu
	cmp cl,10 ; sprawdzenie czy naciœniêto Enter
	je byl_enter ; skok, gdy naciœniêto Enter
	sub cl, 30H ; zamiana kodu ASCII na wartoœæ cyfry
	movzx ecx, cl ; przechowanie wartoœci cyfry w
	; rejestrze ECX
	; mno¿enie wczeœniej obliczonej wartoœci razy 10
	mul dword PTR dziesiec
	add eax, ecx ; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki ; skok na pocz¹tek pêtli
	byl_enter:
	; wartoœæ binarna wprowadzonej liczby znajduje siê teraz w rejestrze EAX
	pop ecx
	pop ebx
	ret
wczytaj_do_EAX ENDP

wyswietl_EAX_hex PROC
	; wyœwietlanie zawartoœci rejestru EAX
	; w postaci liczby szesnastkowej
	pusha ; przechowanie rejestrów

	; rezerwacja 12 bajtów na stosie (poprzez zmniejszenie
	; rejestru ESP) przeznaczonych na tymczasowe przechowanie
	; cyfr szesnastkowych wyœwietlanej liczby
	sub esp, 12
	mov edi, esp ; adres zarezerwowanego obszaru
	; pamiêci
	; przygotowanie konwersji
	mov ecx, 8 ; liczba obiegów pêtli konwersji
	mov esi, 1 ; indeks pocz¹tkowy u¿ywany przy
	; zapisie cyfr
	; pêtla konwersji
	ptl3hex:
	; przesuniêcie cykliczne (obrót) rejestru EAX o 4 bity w lewo
	; w szczególnoœci, w pierwszym obiegu pêtli bity nr 31 - 28
	; rejestru EAX zostan¹ przesuniête na pozycje 3 - 0
	rol eax, 4
	; wyodrêbnienie 4 najm³odszych bitów i odczytanie z tablicy
	; 'dekoder' odpowiadaj¹cej im cyfry w zapisie szesnastkowym
	mov ebx, eax ; kopiowanie EAX do EBX
	and ebx, 0000000FH ; zerowanie bitów 31 - 4 rej.EBX
	mov dl, dekoder[ebx] ; pobranie cyfry z tablicy
	; przes³anie cyfry do obszaru roboczego
	mov [edi][esi], dl
	inc esi ;inkrementacja modyfikatora
	loop ptl3hex ; sterowanie pêtl¹

	mov ecx, 8
	mov esi, 1
	zamienWSpacje:
	mov dl, [edi][esi]
	cmp	dl, '0'
	jne	dalej
	mov dl, ' '
	mov [edi] [esi], dl
	inc esi
	loop	zamienWSpacje
	dalej:
	; wpisanie znaku nowego wiersza przed i po cyfrach
	mov byte PTR [edi][0], 10
	mov byte PTR [edi][9], 10
	; wyœwietlenie przygotowanych cyfr
	push 10 ; 8 cyfr + 2 znaki nowego wiersza
	push edi ; adres obszaru roboczego
	push 1 ; nr urz¹dzenia (tu: ekran)
	call __write ; wyœwietlenie
	; usuniêcie ze stosu 24 bajtów, w tym 12 bajtów zapisanych
	; przez 3 rozkazy push przed rozkazem call
	; i 12 bajtów zarezerwowanych na pocz¹tku podprogramu
	add esp, 24

	popa ; odtworzenie rejestrów
	ret ; powrót z podprogramu
wyswietl_EAX_hex ENDP



wyswietl_EAX PROC
	pusha
	sub esp, 12
	mov ecx, esp
	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ebx, 10 ; dzielnik równy 10
konwersja:
	mov edx, 0 ; zerowanie starszej czêœci dzielnej
	div ebx ; dzielenie przez 10, reszta w EDX,
	; iloraz w EAX
	add dl, 30H ; zamiana reszty z dzielenia na kod
	; ASCII
	mov [ecx] [esi], dl; zapisanie cyfry w kodzie ASCII
	dec esi ; zmniejszenie indeksu
	cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype³nienie pozosta³ych bajtów spacjami i wpisanie
	; znaków nowego wiersza
wypeln:
	or esi, esi
	jz wyswietl ; skok, gdy ESI = 0
	mov byte PTR [ecx] [esi], 20H ; kod spacji
	dec esi ; zmniejszenie indeksu
	jmp wypeln
wyswietl:
	mov byte PTR [ecx] [0], 0AH ; kod nowego wiersza
	mov byte PTR [ecx] [11], 0AH ; kod nowego wiersza
	; wyœwietlenie cyfr na ekranie
	push dword PTR 12 ; liczba wyœwietlanych znaków
	push dword PTR ecx ; adres wyœw. obszaru
	push dword PTR 1; numer urz¹dzenia (ekran ma numer 1)
	call __write ; wyœwietlenie liczby na ekranie
	add esp, 24 ; usuniêcie parametrów ze stosu
	popa
	ret
wyswietl_EAX ENDP

_main PROC
	call wczytaj_do_EAX

	call wyswietl_EAX_hex	

	push 0
	call _ExitProcess@4
_main ENDP
END