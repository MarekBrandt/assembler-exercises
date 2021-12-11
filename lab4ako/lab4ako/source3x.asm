.686
.model flat

public _szukaj_elem_max 

.data
.code
_szukaj_elem_max PROC
push ebp
mov ebp, esp
push ebx
push edi
mov edx, [ebp+8] ; adres tablicy
mov ecx, [ebp+12] ; liczba elementow w tablicy
mov ebx, 1 ; iterator

mov eax, edx
ptl:
mov edi, [edx+4*ebx]
cmp [eax], edi
jge dalej
mov [eax], edi
dalej:
inc ebx
loop ptl
pop edi
pop ebx
pop ebp
ret
_szukaj_elem_max ENDP
END