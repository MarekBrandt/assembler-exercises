.686
.model flat

public _dzielenie

.data
.code
_dzielenie PROC
push ebp
mov ebp, esp
push edi
push ebx
push esi
mov ecx, [ebp+12] ; addres adresu dzielnika
mov ebx, [ebp+8] ; adres dzielnej
mov edi, [ecx] ; adres dzielnika
mov esi, [edi] ; dzielnik
mov eax, ebx ; wartosc dzielnej
cmp eax, 0
jl ujemna
mov edx, 0 ; zerowanie starszej czesci
jmp dalej
ujemna:
mov edx, 0FFFFFFFFh
dalej:
idiv	esi
pop esi
pop ebx
pop edi
pop ebp
ret
_dzielenie ENDP
END