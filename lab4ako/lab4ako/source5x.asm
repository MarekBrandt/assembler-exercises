.686
.model flat

public _check_system_dir
extern _GetSystemDirectoryA@8 : PROC

.data
.code
_check_system_dir PROC
push ebp
mov ebp, esp
sub esp, 32 ; rezerowanie obszaru pamieci na stosie
push edi
push ebx
lea eax, [ebp-32] ; pobieranie adresu obszaru
push 32 ; liczba znakow
push eax ; adres obszaru pamieci na stosie
call _GetSystemDirectoryA@8
mov ecx, eax ; w ecx jest liczba znakow
mov eax, [ebp+8]
mov edi, 0 ; inteerator
ptl:
mov edx, [ebp+edi-32] ; pobieranie znaku z buforu z funkcji
mov ebx, [eax+edi] ; pobieranie znaku z buforu ze stossu
cmp bl, dl ; porownanie znakow
je dalej
mov eax, 0
jmp koniec
dalej:
inc edi
loop ptl

mov al, [eax+edi]
cmp al, 0
je dalej2
cmp al, '\'
je dalej2
mov eax,0
jmp koniec
dalej2:
mov eax, 1
koniec:
pop ebx
pop edi
add esp, 32
pop ebp
ret
_check_system_dir ENDP
END