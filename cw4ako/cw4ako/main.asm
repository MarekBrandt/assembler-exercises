.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public _main

.data
; "Polaczenie zostalo nawiazane", 5 (w kólku)
; tablica zawiera 36 bajtów
bufor		db	50H, 6FH, 0C5H, 82H, 0C4H, 85H, 63H, 7AH, 65H, 6EH, 69H, 65H, 20H
			db	7AH, 6FH, 73H, 74H, 61H, 0C5H, 82H, 6FH, 20H, 6EH, 61H, 77H, 69H
			db	0C4H, 85H, 7AH, 61H, 6EH, 65H, 2EH
			db	0E2H, 91H, 0A4H	; kod znaku '5' w kólku (kod 3-bajtowy, U+2464)

; rezerwacja pamieci na kody wynikowe
; jesli beda wylacznie kody z podstawowego zestawu ASCII, to trzeba
; zarezerwowac 2*36 + 2 (zero 16-bitowe na koncu ciagu znaków)
wynik		db	74 dup (?)	
							 

.code
_main PROC
	mov		ecx, 36		; liczba bajtów tablicy zródlowej
	mov		esi, OFFSET bufor
	mov		edi, OFFSET wynik

przetwarzanie:
	mov		bx, 0
	mov		al, [esi]
	rcl		al, 1
	jc		wielobajtowy
	
	; najprostszy przypadek - znak kodowany na 7 bitach
	rcr		al, 1
	mov		bl, al
	add		esi, 1
	sub		ecx, 1
	jmp		gotowe
	
wielobajtowy:
	rcl		al, 2
	jc		trzy_bajty

	; przypadek dwubajtowy 
	rcr		al, 3
	and		al, 00011111B
	mov		bl, al
	shl		bx, 6
	mov		al, [esi+1]
	and		al,	00111111B
	or		bl, al
	add		esi, 2
	sub		ecx, 2
	jmp		gotowe

trzy_bajty:

	rcr		al, 3
	mov		bh, [esi+1]
	and		bh, 00111111B
	shr		bx, 2

	and		al, 00001111B
	shl		al, 4
	or		bh, al

	mov		al, [esi+2]
	and		al, 00111111B
	or		bl, al

	add		esi, 3
	sub		ecx, 3

gotowe:
	mov		[edi], bx
	add		edi, 2
	or		ecx, ecx
	jnz		przetwarzanie		

	mov		word PTR[edi], 0

	push	0
	push	OFFSET wynik
	push	OFFSET wynik
	push	0
	call	_MessageBoxW@16

	push	0
	call	_ExitProcess@4

_main ENDP
END