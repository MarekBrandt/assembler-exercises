.686
.model flat

extern _malloc : PROC
public _funkcja
.data
.code
_funkcja PROC
push ebp
mov ebp, esp
push edi
mov eax, [ebp+8]
mov edx, 4
mul edx
push eax
call _malloc
add esp, 4 ; w eax jest teraz adres zarezerowawanego obszaru pamieci
cmp eax, 0
jnz dalej
mov [ebp+8],dword ptr -1 ; eax, ecx, edx
pop ebp
ret
dalej:
mov ecx, [ebp+8]
mov edx, 0 ; iterator
ptl:
mov edi, edx
add edi, edx
add edi, edx
dec edi
mov [eax+4*edx], edi;wyrazenie 3*h -1 oblicz i wstaw do rejestru
inc edx
loop ptl
mov eax, [ebp+8]
pop edi
pop ebp
ret
_funkcja ENDP
END