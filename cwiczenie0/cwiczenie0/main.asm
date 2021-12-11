.686
.model flat

public _main

extern	_MessageBoxA@16 : PROC
extern	_ExitProcess@4 : PROC	
extern	_MessageBeep@4 : PROC	

.data
	tytul db 'Testujemy', 0
	tresc db 'Czy wyslac sygnal dzwiekowy?', 0


.code
_main PROC	

	push 24h
	push OFFSET tytul
	push OFFSET tresc
	push 0

	call _MessageBoxA@16

	;cmp eax, 6

	sub eax, 6
	jnz koniec

	push 0
	call _MessageBeep@4

koniec:
	push 0
	call _ExitProcess@4
_main ENDP

END