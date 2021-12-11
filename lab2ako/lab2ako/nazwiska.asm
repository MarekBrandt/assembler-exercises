.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main
.data
tekst_pocz db 10, 'Wprowadz imie i nazwisko'
db ' i nacisnij enter', 10
koniec_t db ?
magazyn db 80 dup (?)
magazyn2 db 80 dup (?)
liczba_znakow dd ?
liczba_znakow_nazwisko dd ?
liczba_znakow_imie dd ?
pocz_nazwisko dd ?

.code
_main PROC

mov ecx, (OFFSET koniec_t) - (OFFSET tekst_pocz)
push ecx
push OFFSET tekst_pocz
push 1
call __write
add esp, 12

push 80
push OFFSET magazyn
push 0
call __read
add esp, 12

mov liczba_znakow, eax
mov ecx, eax
mov ebx, 0 ;indeks pocz

ptl: mov dl, magazyn[ebx]
cmp dl, 20
je dalej
mov magazyn2[ebx], dl
inc ebx
loop	ptl
dalej:
dec	ebx
mov liczba_znakow_imie, ebx
add ebx, 2
mov pocz_nazwisko, ebx

mov eax, 0

ptl2: mov dl, magazyn[ebx]

mov magazyn[eax], dl
inc ebx
inc eax
loop	ptl2
mov magazyn[eax], 20





push liczba_znakow
push OFFSET magazyn2
push 1
call __write
push 0
call _ExitProcess@4
_main ENDP
END